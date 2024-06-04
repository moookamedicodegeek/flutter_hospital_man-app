import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hospital_management_app/models/providers/review_provider.dart';

// This page allows users to leave a review for a hospital.

class ReviewPage extends StatelessWidget {
  ReviewPage({super.key});

  final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context); // Access the review provider

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leave a Review', 
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: reviewProvider.hospitalNameController, 
                decoration: const InputDecoration(
                  labelText: 'Hospital Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a hospital name'; 
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: reviewProvider.feedbackController,
                decoration: const InputDecoration(
                  labelText: 'Feedback',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5, 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your feedback'; 
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await reviewProvider.addReview(); // Add the review
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Review added')), // Show success message
                      );
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add review: $error')), 
                      );
                    }
                  }
                },
                icon: const Icon(Icons.send), 
                label: const Text('Submit'), 
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.teal, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
