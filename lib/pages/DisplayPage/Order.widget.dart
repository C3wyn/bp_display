import 'package:bp_display/models/API/APIResponse.model.dart';
import 'package:bp_display/models/Order/DeliveryType.enum.dart';
import 'package:bp_display/models/Order/Extras.model.dart';
import 'package:bp_display/models/Order/Ingredients.model.dart';
import 'package:bp_display/models/Order/Order.model.dart';
import 'package:bp_display/models/Order/OrderStatus.enum.dart';
import 'package:bp_display/services/APIService/API.Service.dart';
import 'package:bp_display/services/OrderService/Order.Service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/Order/OrderItem.model.dart';

class OrderWidget extends StatefulWidget {

  Order order;

  OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.order.ID.toString(), style: Theme.of(context).textTheme.displayMedium),
                  _chooseDeliveryTypeIcon(widget.order.deliveryType, context),
                ],
              ),
              widget.order.createdAt==widget.order.pickUpDate?Container():
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.inbox, size: Theme.of(context).textTheme.displaySmall?.fontSize),
                      Text(DateFormat('hh:mm').format(widget.order.createdAt), style: Theme.of(context).textTheme.displaySmall),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.outbox, size: Theme.of(context).textTheme.displaySmall?.fontSize),
                      Text(DateFormat('hh:mm').format(widget.order.pickUpDate), style: Theme.of(context).textTheme.displaySmall),
                    ],
                  )
                ],
              ),
              const Divider(),
              _buildItems(widget.order.items),
              const Divider(),
              widget.order.status==OrderStatus.Done?
              Container():
              FilledButton.icon(
                icon: Icon(Icons.check, size: Theme.of(context).textTheme.titleMedium?.fontSize),
                onPressed: () => _checkOrder(context), 
                label: Text('Erledigt', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black))
              )
            ],
          ),
        ),
      ),
    );
  }
  
  _buildItems(List<OrderItem> items) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(items[index].Name, style: Theme.of(context).textTheme.titleLarge),
              _buildSelectedIngredients(items[index]),
              _buildExtras(items[index]),
              index!=items.length-1?const Divider(): Container()
            ],
          ),
        );
      }
    );
  }

  Widget _buildSelectedIngredients(OrderItem item) {
    List<Widget> widgets = [];
    for(Ingredient ingredient in item.selectedIngredients) {
      if(ingredient.Default && !ingredient.Selected){
        widgets.add(
          Text('OHNE ${ingredient.Name}', style: Theme.of(context).textTheme.bodyLarge)
        );
      }else if(!ingredient.Default && ingredient.Selected){
        widgets.add(
          Text('MIT ${ingredient.Name}', style: Theme.of(context).textTheme.bodyLarge)
        );
      }
    }
    return Column(
      children: widgets,
    );
  }

  Icon _chooseDeliveryTypeIcon(DeliveryType deliveryType, BuildContext context) {
    var iconStyle = Theme.of(context).textTheme.displayMedium?.fontSize;
    switch(deliveryType) {
      case DeliveryType.TakeAway:
        return Icon(Icons.delivery_dining, size: iconStyle,);
      case DeliveryType.EatHere:
        return Icon(Icons.storefront, size: iconStyle);
      default:
      return Icon(Icons.device_unknown, size: iconStyle);
    }
  }

  _checkOrder(BuildContext context) async {
    widget.order.status = OrderStatus.Done;
    APIResponse response = await APIService.updateOrder(widget.order);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Successfully updated order ${widget.order.ID}")
      )
    );
  }
  
  _buildExtras(OrderItem item) {
    List<Widget> widgets = [];
    for(Extra extra in item.selectedExtras) {
      widgets.add(
        Text('MIT ${extra.Name}', style: Theme.of(context).textTheme.bodyLarge)
      );
    }
    return Column(
      children: widgets,
    );
  }
}