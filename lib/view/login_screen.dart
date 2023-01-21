import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/until.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../res/components/button.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {

  ValueNotifier<bool>obscurePassword = ValueNotifier<bool>(true);

  final userController = TextEditingController();
  final passController = TextEditingController();

  FocusNode emailFocusNode    = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    userController.dispose();
    passController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello there!',
                            style: GoogleFonts.poppins(fontSize: 20)),
                        Text('Welcome',
                            style: GoogleFonts.poppins(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20,),

                Image.network(
                    'https://img.freepik.com/premium-vector/hospital-care-mobile-app-check-screening-patient-health-by-filling-out-survey-vector-illustration-design-can-use-landing-page-template-ui-ux-web-social-media-poster-banner-website-flyer-ad_4968-1897.jpg?w=2000'
                ),
                Text('Login', style: GoogleFonts.poppins(
                    fontSize: 25, fontWeight: FontWeight.w600)),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    const Icon(Icons.alternate_email, color: Colors.grey,),
                    const SizedBox(width: 15,),
                    SizedBox(
                      width: 330,
                      child: TextField(
                        controller: userController,
                        focusNode: emailFocusNode ,
                        decoration: InputDecoration(
                          hintText: 'Email ID',
                          hintStyle: GoogleFonts.poppins(fontSize: 13),
                        ),
                        style: GoogleFonts.poppins(fontSize: 14),
                        onSubmitted:(value){
                          Until.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                ValueListenableBuilder(
                    valueListenable: obscurePassword,
                    builder: (context,value,child){
                      return  Row(
                        children: [
                          const Icon(Icons.lock, color: Colors.grey,),
                          const SizedBox(width: 15,),
                          SizedBox(
                            width: 330,
                            child: TextField(
                              controller: passController,
                              focusNode: passwordFocusNode,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: GoogleFonts.poppins(fontSize: 13),
                                suffixIcon:InkWell(
                                  onTap:(){
                                    obscurePassword.value = !obscurePassword.value;
                      },child:Icon(
                                      obscurePassword.value ? Icons.visibility_off_outlined:
                                           Icons.visibility,
                                    )),
                              ),
                              style: GoogleFonts.poppins(fontSize: 14),
                              obscureText: obscurePassword.value,
                            ),
                          ),
                        ],
                      );
                    }),

                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot password?', style: GoogleFonts.poppins(
                        fontSize: 10, color: Colors.lightGreen),)
                  ],
                ),
                const SizedBox(height: 30,),

                Button(
                  title: 'Login',
                  loading: authViewModel.loading,
                  onPress: (){
                    if(userController.text.isEmpty){
                      Until.flushBarErrorMessage('please enter email', context);
                     }else if(passController.text.isEmpty){
                      Until.flushBarErrorMessage('please enter password', context);
                    }else if(passController.text.length<6){
                      Until.flushBarErrorMessage('please enter 6 digit password', context);
                    }else{
                      Map data ={
                        'email'    : userController.text,
                        'password' : passController.text,
                      };
                      authViewModel.loginApi(data , context);
                    }
                  },
                ),

                const SizedBox(height: 10,),
                Center(child: Text('or', style: GoogleFonts.poppins(
                    color: Colors.grey, fontSize: 10),)),
                const SizedBox(height: 10,),
                Container(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 16.0,
                          spreadRadius: .2
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                            scale: 30,),
                          const SizedBox(width: 10,),
                          Text('Login with Google', style: GoogleFonts.poppins(
                              color: Colors.black38, fontSize: 13),),

                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('create new account?',
                      style: GoogleFonts.poppins(fontSize: 10),),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.signUp);
                        },
                        child: Text('Register', style: GoogleFonts.poppins(
                            fontSize: 10, color: Colors.lightGreen)))
                  ],
                )
              ],
            ),
          ),
        ),
      ),);
  }

}
