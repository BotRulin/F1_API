import 'drivers_model.dart';
import 'drivers_detail_page.dart';
import 'package:flutter/material.dart';


class PilotCard extends StatefulWidget 
{
  final Driver driver;

  const PilotCard(this.driver, {super.key});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _PilotCardState createState() => _PilotCardState(driver);
}

class _PilotCardState extends State<PilotCard> 
{
  Driver pilot;
  String? renderUrl;

  _PilotCardState(this.pilot);

  @override
  void initState() 
  {
    super.initState();
    renderPilotPic();
  }

  Widget get pilotImage 
  {
    var pilotAvatar = Hero
    (
      tag: pilot,
      child: Container
      (
        width: 100.0,
        height: 100.0,
        decoration:
            BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(renderUrl ?? ''))),
      ),
    );

    var placeholder = Container
    (
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration
      (
          shape: BoxShape.circle,
          gradient:
              LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.black54, Colors.black, Color.fromARGB(255, 84, 110, 122)])
      ),
      alignment: Alignment.center,
      child: const Text
      (
        'Pilot',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = AnimatedCrossFade
    (
      firstChild: placeholder,
      secondChild: pilotAvatar,
      // ignore: unnecessary_null_comparison
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderPilotPic() async 
  {
    await pilot.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = pilot.imageUrl;
      });
    }
  }

  Widget get pilotCard 
  {
    return Positioned
    (
      right: 0.0,
      child: SizedBox
      (
        width: 290,
        height: 115,
        child: Card
        (
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: const Color(0xFFF8F8F8),
          child: Padding
          (
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>
              [
                Text
                (
                  widget.driver.completeName ?? '',
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 27.0),
                ),
                Text
                (
                  widget.driver.teamRace ?? '',
                  style: const TextStyle(color: Color(0xFF000600)),
                ),
                
                Row
                (
                  children: <Widget>
                  [
                    const Icon(Icons.star, color: Color(0xFF000600)),
                    Text(': ${widget.driver.rating}/5', style: const TextStyle(color: Color(0xFF000600), fontSize: 14.0))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showPilotDetailPage() async 
  {
    final updatedRating = await Navigator.of(context).push
    (
      MaterialPageRoute(builder: (context) 
      {
        return PilotDetailPage(pilot);
      }),
    );

    if (updatedRating != null) 
    {
      setState(() 
      {
        pilot.rating = updatedRating;
      });
    }
  }


  @override
  Widget build(BuildContext context) 
  {
    return InkWell
    (
      onTap: () => showPilotDetailPage(),
      child: Padding
      (
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox
        (
          height: 115.0,
          child: Stack
          (
            children: <Widget>
            [
              pilotCard,
              Positioned(top: 7.5, child: pilotImage),
            ],
          ),
        ),
      ),
    );
  }
}
