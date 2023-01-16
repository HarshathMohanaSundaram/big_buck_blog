import 'package:big_bucks_blog/model/CompanyModel.dart';
import 'package:big_bucks_blog/screens/companyData.dart';
import 'package:flutter/material.dart';

class Company extends StatelessWidget {
  const Company({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: company.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CompanyStock(
                        api: company[index].api,
                        title: company[index].name,
                      ))),
          child: Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(company[index].image),
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                company[index].name,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
        );
      },
    );
  }
}
