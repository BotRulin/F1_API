import 'drivers_card.dart';
import 'package:flutter/material.dart';
import 'drivers_model.dart';

class PilotList extends StatelessWidget 
{
  final List<Driver> pilots;
  const PilotList(this.pilots, {super.key});

  @override
  Widget build(BuildContext context) 
  {
    return _buildList(context);
  }

  ListView _buildList(context) 
  {
    return ListView.builder(
      itemCount: pilots.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) 
      {
        return PilotCard(pilots[int]);
      },
    );
  }
}
