import 'drivers_card.dart';
import 'package:flutter/material.dart';
import 'drivers_model.dart';
import 'dart:async';


class PilotDetailPage extends StatefulWidget 
{
  final Driver pilot;
  const PilotDetailPage(this.pilot, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PilotDetailPageState createState() => _PilotDetailPageState();
}

class _PilotDetailPageState extends State<PilotDetailPage> 
{
  final double pilotAvarterSize = 150.0;
  double _rating = 5.0;

  Widget get addYourRating 
  {
    return Column
    (
      children: <Widget>
      [
        Container
        (
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
              Row(
                children: List.generate(5, (index) 
                {
                  double rating = index + 1.0;
                  return GestureDetector
                  (
                    onTap: () 
                    {
                      setState(() 
                      {
                        _rating = rating;
                      });
                    },
                    child: Icon
                    (
                      _rating >= rating ? Icons.star : Icons.star_border,
                      color: const Color(0xFF0B479E),
                      size: 40.0,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() 
  {
    if (_rating < 2.5) 
    {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.pilot.rating = _rating.toInt();
        Navigator.pop(context, widget.pilot.rating);
        PilotCard(widget.pilot);
      });
    }
  }

  Future<void> _ratingErrorDialog() async 
  {
    return showDialog(
      context: context,
      builder: (BuildContext context) 
      {
        return AlertDialog
        (
          title: const Text('Error!'),
          content: const Text("Come on! They're good!"),
          actions: <Widget>
          [
            TextButton
            (
              child: const Text('Try Again'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(),
      child: const Text('Submit'),
    );
  }

  Widget get pilotImage 
  {
    return Hero
    (
      tag: widget.pilot,
      child: Container
      (
        height: pilotAvarterSize,
        width: pilotAvarterSize,
        constraints: const BoxConstraints(),
        decoration: BoxDecoration
        (
            shape: BoxShape.circle,
            boxShadow: const 
            [
              BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: Color(0x33000000)),
              BoxShadow(offset: Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: Color(0x24000000)),
              BoxShadow(offset: Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: Color(0x1f000000))
            ],
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(widget.pilot.imageUrl ?? ""))
        ),
      ),
    );
  }

  Widget get rating 
  {
    return Row
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>
      [
        const Icon
        (
          Icons.star,
          size: 40.0,
          color: Colors.black,
        ),
        Text('${widget.pilot.rating}/5', style: const TextStyle(color: Colors.black, fontSize: 30.0))
      ],
    );
  }

  Widget get pilotProfile 
  {
    return Container
    (
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration
      (
        color: Color(0xFFABCAED),
      ),
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>
        [
          pilotImage,
          Text(widget.pilot.id, style: const TextStyle(color: Colors.black, fontSize: 32.0)),
          Text('${widget.pilot.teamRace}', style: const TextStyle(color: Colors.black, fontSize: 20.0)),
          Padding
          (
            padding: const EdgeInsets.only(top: 20.0),
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: const Color(0xFFABCAED),
      appBar: AppBar
      (
        backgroundColor: const Color(0xFF0B479E),
        title: Text('Meet ${widget.pilot.completeName}'),
      ),
      body: ListView
      (
        children: <Widget>[pilotProfile, addYourRating],
      ),
    );
  }
}
