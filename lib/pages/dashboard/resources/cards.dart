// import 'package:flutter/material.dart';
// import '../components/draggable_card_widget.dart';

// const List<String> intrests = ['Travelling', 'Fitness', 'Music'];
// List<Widget> cardList = [
//    DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//    DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sahil Verma',
//     age: 21,
//     miles: 1.4,
//     about:
//         'Do you know what I have in common with the Little Mermaid? We both want to be part of your world.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Sanket Gupta',
//     age: 22,
//     miles: 2.1,
//     about:
//         'My BBQ is broken, could you have a look at it? (What?) Oh, I thought you might be able to help, being smoking hot yourself and all.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Ankit Shrivastav',
//     age: 24,
//     miles: 4.1,
//     about: 'Are you the COVID vaccine? Because I would never turn you down.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Vishnu Vardhan',
//     age: 22,
//     miles: 0.2,
//     about:
//         'Do you have an Instagram? My mom always told me to follow my dreams.',
//     intrests: intrests,
//   ),
//   const DraggableCardWidget(
//     name: 'Smit Modi',
//     age: 32,
//     miles: 5.2,
//     about:
//         'I bet I know when your birthday is. October 10. Because you’re a 10/10.',
//     intrests: intrests,
//   ),
// ];
