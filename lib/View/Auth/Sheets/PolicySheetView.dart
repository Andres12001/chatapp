import 'package:first_app/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/WelcomeHeader.dart';

class PolicySheetView extends StatelessWidget {
  PolicySheetView({super.key});
  static const String screenRouteName = "/Policy";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "Metix",
          style: GoogleFonts.lobster(
              textStyle: const TextStyle(color: Colors.white)),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(children: [
                  //main container
                  WelcomeHeader(
                    size: size,
                    title: 'Privacy Policy',
                    fontSize: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Gravida rutrum quisque non tellus orci ac auctor. Malesuada nunc vel risus commodo. Blandit cursus risus at ultrices mi tempus imperdiet nulla. Arcu dui vivamus arcu felis bibendum ut tristique et. Interdum consectetur libero id faucibus nisl tincidunt eget nullam non. Varius morbi enim nunc faucibus a pellentesque sit. Orci porta non pulvinar neque laoreet suspendisse interdum. Scelerisque felis imperdiet proin fermentum leo vel orci. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim diam.

Facilisis volutpat est velit egestas dui. Ac auctor augue mauris augue neque gravida in. Volutpat diam ut venenatis tellus in metus vulputate eu scelerisque. Turpis massa tincidunt dui ut ornare. Elit duis tristique sollicitudin nibh sit amet commodo. Quam elementum pulvinar etiam non quam lacus. Sapien nec sagittis aliquam malesuada bibendum. Turpis egestas maecenas pharetra convallis posuere morbi leo. Ullamcorper eget nulla facilisi etiam dignissim diam quis enim. Sagittis vitae et leo duis. Amet nisl purus in mollis nunc sed id semper. Quam lacus suspendisse faucibus interdum posuere lorem. Sed faucibus turpis in eu. Nisl nunc mi ipsum faucibus vitae. Eget dolor morbi non arcu risus quis. Quam quisque id diam vel quam elementum pulvinar. In hendrerit gravida rutrum quisque non. Vulputate dignissim suspendisse in est ante in nibh.

Magna fermentum iaculis eu non diam phasellus vestibulum. Gravida arcu ac tortor dignissim convallis aenean et tortor. Arcu cursus euismod quis viverra nibh cras pulvinar. Morbi tempus iaculis urna id volutpat. Feugiat pretium nibh ipsum consequat nisl. In eu mi bibendum neque egestas congue quisque. Aliquam ut porttitor leo a diam sollicitudin tempor id eu. Volutpat consequat mauris nunc congue nisi vitae. Et ligula ullamcorper malesuada proin libero nunc consequat interdum. Gravida arcu ac tortor dignissim convallis. Tempor nec feugiat nisl pretium fusce id. Netus et malesuada fames ac turpis egestas maecenas pharetra.

Commodo odio aenean sed adipiscing. Morbi tempus iaculis urna id volutpat. Tellus mauris a diam maecenas sed enim. Id consectetur purus ut faucibus pulvinar. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Viverra orci sagittis eu volutpat. Ornare arcu odio ut sem nulla pharetra. Volutpat blandit aliquam etiam erat velit scelerisque in dictum non. At in tellus integer feugiat scelerisque varius. Orci sagittis eu volutpat odio facilisis mauris sit amet massa. Integer enim neque volutpat ac tincidunt. Dolor sit amet consectetur adipiscing elit ut aliquam purus sit. Elit at imperdiet dui accumsan sit. Posuere urna nec tincidunt praesent semper feugiat nibh sed pulvinar.

Lorem ipsum dolor sit amet consectetur adipiscing. Sed vulputate mi sit amet mauris commodo. Nulla aliquet enim tortor at auctor urna nunc id. Aenean sed adipiscing diam donec adipiscing tristique risus nec. Bibendum enim facilisis gravida neque convallis a. Eget mi proin sed libero enim sed faucibus turpis. At urna condimentum mattis pellentesque id nibh tortor. Cursus mattis molestie a iaculis at. Donec pretium vulputate sapien nec sagittis. Nibh nisl condimentum id venenatis a condimentum vitae sapien pellentesque. Pharetra magna ac placerat vestibulum lectus mauris. Elementum sagittis vitae et leo duis. Id aliquet lectus proin nibh. Consectetur adipiscing elit duis tristique sollicitudin nibh sit amet. Suspendisse potenti nullam ac tortor. Orci dapibus ultrices in iaculis nunc. Ac placerat vestibulum lectus mauris ultrices eros in cursus. Et ligula ullamcorper malesuada proin. Id donec ultrices tincidunt arcu non sodales neque sodales."""),
                  )
                  // JoinSheetContent(joinSheetVM: _joinSheetVM)
                  //overlay container
                ]),
              ),
            ]),
      ),
    );
  }
}
