import 'package:flutter/material.dart';

import '../models/product.dart';

const catalog = [
  Product(
    id: 'hoodie',
    name: 'Shorebird Hoodie',
    description: 'Heavyweight cotton, embroidered bird.',
    priceCents: 5900,
    icon: Icons.checkroom,
    color: Color(0xFF1F3C88),
  ),
  Product(
    id: 'tee',
    name: 'Code Push Tee',
    description: 'Soft crew-neck tee with a small bird on the chest.',
    priceCents: 2490,
    icon: Icons.dry_cleaning,
    color: Color(0xFFE4572E),
  ),
  Product(
    id: 'mug',
    name: 'Patch Notes Mug',
    description: 'Holds 350 ml of coffee for release day.',
    priceCents: 1450,
    icon: Icons.coffee,
    color: Color(0xFFD08C12),
  ),
  Product(
    id: 'stickers',
    name: 'Sticker Pack',
    description: 'Eight vinyl stickers for your laptop lid.',
    priceCents: 500,
    icon: Icons.auto_awesome,
    color: Color(0xFF7C4DDB),
  ),
  Product(
    id: 'tote',
    name: 'Canvas Tote',
    description: 'Room for a laptop and every conference freebie.',
    priceCents: 1800,
    icon: Icons.shopping_bag,
    color: Color(0xFF2E8B57),
  ),
  Product(
    id: 'bottle',
    name: 'Water Bottle',
    description: 'Insulated steel. Cold for 24 hours.',
    priceCents: 2200,
    icon: Icons.water_drop,
    color: Color(0xFF1E88C8),
  ),
  Product(
    id: 'pin',
    name: 'Hot Fix Pin',
    description: 'Enamel pin for anyone who has shipped on a Friday.',
    priceCents: 800,
    icon: Icons.push_pin,
    color: Color(0xFFD63A6E),
  ),
  Product(
    id: 'backpack',
    name: 'Dev Backpack',
    description: 'Padded laptop sleeve and a bottle pocket.',
    priceCents: 6900,
    icon: Icons.backpack,
    color: Color(0xFF37474F),
  ),
];
