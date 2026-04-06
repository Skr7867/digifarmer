import 'package:flutter/material.dart';

import '../../../res/fonts/app_fonts.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FAQSection(
          title: "Support & Getting Started",
          items: [
            FAQItem(
              question: "What is DigiFarmer user panel?",
              answer:
                  "The user panel is your personal dashboard where you can manage your farming activities, access training, track analytics, and connect with buyers. It brings all farming tools into one place for easy management.",
            ),
            FAQItem(
              question: "How do I create an account?",
              answer:
                  "Click Get Started and complete registration with OTP verification.",
            ),
            FAQItem(
              question: "How can I contact support?",
              answer: "Support is available via chat, email, and phone.",
            ),
          ],
        ),

        FAQSection(
          title: "Platform & Technology",
          items: [
            FAQItem(
              question: "How does the platform work?",
              answer:
                  "You select a project, invest, and track performance via dashboard.",
            ),
            FAQItem(
              question: "Is there a mobile app available?",
              answer: "Yes, mobile apps are available for Android and iOS.",
            ),
          ],
        ),

        FAQSection(
          title: "Security & Compliance",
          items: [
            FAQItem(
              question: "How is my data protected?",
              answer:
                  "We use encryption and secure servers to protect your data.",
            ),
            FAQItem(
              question: "Is KYC mandatory?",
              answer: "Yes, KYC is required for compliance and security.",
            ),
          ],
        ),

        FAQSection(
          title: "Investment Questions",
          items: [
            FAQItem(
              question: "What returns can I expect?",
              answer: "Returns typically range between 12%–25% annually.",
            ),
          ],
        ),
      ],
    );
  }
}

class FAQSection extends StatelessWidget {
  final String title;
  final List<FAQItem> items;

  const FAQSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Title
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.help_outline, color: Colors.green),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.popins,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// Card
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: items.map((e) => FAQTile(item: e)).toList()),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}

class FAQTile extends StatefulWidget {
  final FAQItem item;

  const FAQTile({super.key, required this.item});

  @override
  State<FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Question
        InkWell(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.item.question,
                    style: const TextStyle(
                      fontSize: 13,

                      fontFamily: AppFonts.popins,
                    ),
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),

        /// Answer
        if (isOpen)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.green.shade50,
            child: Text(
              widget.item.answer,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                fontFamily: AppFonts.popins,
              ),
            ),
          ),
      ],
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  const FAQItem({required this.question, required this.answer});
}
