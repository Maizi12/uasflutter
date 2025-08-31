import 'package:flutter/material.dart';

class FooterCard extends StatelessWidget {
  final String namaMenu;
  
  const FooterCard({super.key, required this.namaMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(5, 17, 20, 177),
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMenuItem(Icons.home, 'Overview', namaMenu == 'Overview'),
          _buildMenuItem(Icons.account_balance_wallet, 'Wallet', namaMenu == 'Wallet'),
          _buildMenuItem(Icons.receipt_long, 'Transaksi', namaMenu == 'Transaksi'),
          _buildMenuItem(Icons.person, 'Profile', namaMenu == 'Profile'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xff2C14DD) : const Color(0xff5C616F),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isActive ? const Color(0xff2C14DD) : const Color(0xff5C616F),
          ),
        ),
      ],
    );
  }
}
