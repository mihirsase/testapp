import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/blocs/dashboard/profile/profile_bloc.dart';
import 'package:testapp/blocs/dashboard/profile/profile_event.dart';
import 'package:testapp/blocs/dashboard/profile/profile_state.dart';
import 'package:testapp/components/atoms/loading_atom.dart';
import 'package:testapp/components/atoms/margin_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';
import 'package:testapp/components/atoms/title_atom.dart';
import 'package:testapp/services/pallete.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (
        final BuildContext _,
        final ProfileState state,
      ) {
        return Scaffold(
          body: _body(state),
        );
      },
    );
  }

  Widget _body(final ProfileState state) {
    if (state is ProfileLoading) {
      return LoadingAtom(
        onRefresh: () async {
          _profileBloc.add(LoadProfile());
        },
      );
    }

    return RefreshAtom(
      onRefresh: () async {
        _profileBloc.add(LoadProfile());
      },
      child: ListView(
        children: [
          TitleAtom(
            title: 'User Profile',
            leading: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.account_circle,
                size: 72,
                color: Pallete.greyLight,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          MarginAtom(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BASIC INFORMATION',
                  style: TextStyle(
                    color: Pallete.greyLight,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                _detailRow(key: 'Name', value: _profileBloc.user.name ?? ''),
                _detailRow(key: 'Email Address', value: _profileBloc.user.email ?? ''),
                _detailRow(key: 'Password', value: _profileBloc.user.username ?? ''),
                _detailRow(key: 'Phone no.', value: _profileBloc.user.phone ?? ''),
                _detailRow(key: 'Website', value: _profileBloc.user.website ?? ''),
                _detailRow(key: 'Company', value: _profileBloc.user.company ?? ''),
                SizedBox(
                  height: 34,
                ),
                Text(
                  'ADDRESS INFORMATION',
                  style: TextStyle(
                    color: Pallete.greyLight,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                _detailRow(key: 'Street', value: _profileBloc.user.address?.street ?? ''),
                _detailRow(key: 'Suite', value: _profileBloc.user.address?.suite ?? ''),
                _detailRow(key: 'City', value: _profileBloc.user.address?.city ?? ''),
                _detailRow(key: 'Zipcode', value: _profileBloc.user.address?.zipcode ?? ''),
                SizedBox(
                  height: 34,
                ),
                GestureDetector(
                  onTap: (){
                    _profileBloc.add(Logout());
                  },
                  child: Text(
                    'LOGOUT',
                    style: TextStyle(
                      color: Pallete.greyLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow({
    required String key,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: TextStyle(
              color: Pallete.white,
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: TextStyle(
                  color: Pallete.greyLight,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
