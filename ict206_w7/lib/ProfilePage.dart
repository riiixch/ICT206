import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              'https://scontent.fbkk15-1.fna.fbcdn.net/v/t39.30808-6/409452990_1684268345414536_7161467506035782132_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeGlN96l4d64drRoaz-mDWIb_4S7EuCUJcr_hLsS4JQlym4Zzl7SaM6JR9NLKYB2pNfOwxdJfFwV8aLbGsl_YDqO&_nc_ohc=rjU6CQhsd0YQ7kNvgGOFthI&_nc_oc=AdgtGYURIrsT_Z5FdPU1hOOvNaVukphSOdgeV43SK8hhrGmHqDYMT1DtgnaPqi1o3Zk&_nc_zt=23&_nc_ht=scontent.fbkk15-1.fna&_nc_gid=A8r8drEiUccOaJ7CmRu0BEh&oh=00_AYAohflvOHIjizETnGpak0DkT-P2PBjvAMaFewW_gP--Rg&oe=67B9D42D',
            ),
          ),
          SizedBox(height: 20),
          Text(
            '65064435',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Sompop Iemsombat',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Information Technology',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            'Information Technology And Communication',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            'Sripatum University Chonburi Campus',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
