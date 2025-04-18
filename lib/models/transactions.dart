import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  String transactionId;
  String uid;
  String createdAt;
  String amount;
  String amountType;
  String transactionFee;
  String type;
  String recipient;
  String? note;
  String desc;
  String time;
  double pointsEarned;
  String senderLeftHeadText;
  String senderLeftSubText;
  String senderRightHeadText;
  String senderRightSubText;
  String recipientLeftHeadText;
  String recipientLeftSubText;
  String recipientRightHeadText;
  String recipientRightSubText;

  TransactionModel(
      {required this.uid,
        required this.createdAt,
        required this.amount,
        required this.amountType,
        required this.transactionId,
        required this.type,
        required this.recipient,
        this.note,
        required this.desc,
        required this.time,
        required this.pointsEarned,
        required this.senderLeftHeadText,
        required this.senderLeftSubText,
        required this.senderRightHeadText,
        required this.senderRightSubText,
        required this.recipientLeftHeadText,
        required this.recipientLeftSubText,
        required this.recipientRightHeadText,
        required this.recipientRightSubText,
        required this.transactionFee,

      });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        transactionId: json["transactionId"],
        uid: json["uid"],
        createdAt: json["createdAt"],
        amount: json["amount"],
        amountType: json["amountType"],
        type: json["type"],
        recipient: json["recipient"],
        note: json["note"],
        desc: json["desc"],
        time: json["time"],
        transactionFee: json["transactionFee"],
        pointsEarned: json["pointsEarned"],
        senderLeftHeadText: json["senderLeftHeadText"],
        senderLeftSubText: json["senderLeftSubText"],
        senderRightHeadText: json["senderRightHeadText"],
        senderRightSubText: json["senderRightSubText"],
        recipientLeftHeadText: json["recipientLeftHeadText"],
        recipientLeftSubText: json["recipientLeftSubText"],
        recipientRightHeadText: json["recipientRightHeadText"],
        recipientRightSubText: json["recipientRightSubText"],

      );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "uid": uid,
    "createdAt": createdAt,
    "amount": amount,
    "amountType": amountType,
    "type": type,
    "recipient": recipient,
    "note": note,
    "desc": desc,
    "time": time,
    "transactionFee": transactionFee,
    "pointsEarned": pointsEarned,
    "senderLeftHeadText": senderLeftHeadText,
    "senderLeftSubText": senderLeftSubText,
    "senderRightHeadText": senderRightHeadText,
    "senderRightSubText": senderRightSubText,
    "recipientLeftHeadText": recipientLeftHeadText,
    "recipientLeftSubText": recipientLeftSubText,
    "recipientRightHeadText": recipientRightHeadText,
    "recipientRightSubText": recipientRightSubText,

  };

  factory TransactionModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return TransactionModel(
      transactionId: data['transactionId'],
      uid: data['uid'],
      createdAt: data['createdAt'],
      amount: data['amount'],
      amountType: data['amountType'],
      type: data['type'],
      recipient: data['recipient'],
      note: data['note'] ?? '',
      desc: data['desc'],
      time: data['time'],
      transactionFee: data['transactionFee'],
      pointsEarned: data['pointsEarned'],
      senderLeftHeadText: data['senderLeftHeadText'],
      senderLeftSubText: data['senderLeftSubText'],
      senderRightHeadText: data['senderRightHeadText'],
      senderRightSubText: data['senderRightSubText'],
      recipientLeftHeadText: data['recipientLeftHeadText'],
      recipientLeftSubText: data['recipientLeftSubText'],
      recipientRightHeadText: data['recipientRightHeadText'],
      recipientRightSubText: data['recipientRightSubText'],
    );
  }

  double convertPointsToPawKoins(double conversionRate) {
    return pointsEarned * conversionRate;
  }

}
