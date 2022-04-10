import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';
import 'package:ranks_test_weather_app/domain/model/hourly_weather.dart';
import 'package:ranks_test_weather_app/domain/model/user_shared_preferences.dart';
import 'package:ranks_test_weather_app/domain/state/home/home_state.dart';
import 'package:ranks_test_weather_app/internal/dependencies/home_module.dart';
import 'package:ranks_test_weather_app/presentation/constants/styling.dart';
import 'package:ranks_test_weather_app/presentation/screens/added_cities_screen.dart';
import 'package:ranks_test_weather_app/presentation/widgets/other_days_weather_bottom_sheet.dart';
import '../../generated/l10n.dart';
import '../dialogs/add_new_city_dialog.dart';
import '../models/additional_weather_info.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeState _homeState = HomeModule.homeState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            return Text(
              _homeState.selectedCityName!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => _showAddNewCityDialog(context, _homeState),
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.secondary,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            constraints: const BoxConstraints(minWidth: 20),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddedCitiesScreen(
                    homeState: _homeState,
                  ),
                ),
              );
            },
            icon: Image.asset(
              'assets/images/cities_icon.png',
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: Styling.screenGradient(
        context,
        SafeArea(
          child: _HomeScreenBody(
            homeState: _homeState,
          ),
        ),
      ),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  final HomeState homeState;
  const _HomeScreenBody({Key? key, required this.homeState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getLastCityWeather(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Styling.screenPadding()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _CurrentTemperatureText(
                          homeState: homeState,
                        ),
                        _CurrentWeatherText(
                          homeState: homeState,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _AllDaysWeatherInfoListView(
                          homeState: homeState,
                        ),
                        _AdditionalWeatherInfoCard(
                          homeState: homeState,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                          ),
                          child: _CheckAnotherDaysWeatherBtn(
                            homeState: homeState,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).getting_data_text,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        });
  }

  Future<bool> _getLastCityWeather(BuildContext context) async {
    if (UserSharedPreferences.getAddedCities().isEmpty) {
      Future.delayed(Duration.zero)
          .then((value) => _showAddNewCityDialog(context, homeState));

      return false;
    } else {
      GeoCode geoCode = GeoCode();

      Coordinates _coordinates = await geoCode.forwardGeocoding(
          address: UserSharedPreferences.getLastCityName());
      await homeState.getWeather(
          latitude: _coordinates.latitude!, longitude: _coordinates.longitude!);
      return true;
    }
  }
}

void _showAddNewCityDialog(BuildContext context, HomeState homeState) {
  showDialog(
    context: context,
    builder: (_) {
      return AddNewCityDialog(
        homeState: homeState,
      );
    },
  );
}

class _AllDaysWeatherInfoListView extends StatelessWidget {
  final HomeState homeState;

  const _AllDaysWeatherInfoListView({Key? key, required this.homeState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TransparentContainer(
      child: Observer(builder: (_) {
        if (homeState.isLoading) return Text(S.of(context).getting_data_text);
        if (homeState.weather == null) return Container();
        return SizedBox(
          width: 300.w,
          height: 90.h,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(8.w),
              scrollDirection: Axis.horizontal,
              itemCount: 25,
              itemBuilder: (context, index) {
                final HourlyWeather hourlyWeather =
                    homeState.weather!.hourlyWeatherList[index];
                return Container(
                  margin: EdgeInsets.only(right: 25.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        hourlyWeather.time,
                        style: Styling.transparentTitleTextStyle(context),
                      ),
                      Text(
                        '${hourlyWeather.temperature} °C',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(
                        hourlyWeather.weatherDescription,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(
                        '${hourlyWeather.windSpeed} ${S.of(context).measure_speed_text}',
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

class _CurrentTemperatureText extends StatelessWidget {
  final HomeState homeState;
  const _CurrentTemperatureText({Key? key, required this.homeState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (homeState.isLoading) return Text(S.of(context).getting_data_text);
        if (homeState.weather == null) return Container();
        return Text(
          '${homeState.weather!.temperature} °C',
          style: TextStyle(
            fontSize: 64.sp,
            color: Theme.of(context).colorScheme.secondary,
          ),
        );
      },
    );
  }
}

class _CurrentWeatherText extends StatelessWidget {
  final HomeState homeState;

  const _CurrentWeatherText({Key? key, required this.homeState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (homeState.isLoading) return Text(S.of(context).getting_data_text);
        if (homeState.weather == null) return Container();
        return Column(
          children: [
            Text(
              homeState.weather!.weatherDescription,
              style: TextStyle(
                fontSize: 20.sp,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AdditionalWeatherInfoCard extends StatelessWidget {
  final HomeState homeState;

  const _AdditionalWeatherInfoCard({Key? key, required this.homeState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TransparentContainer(
      child: Observer(builder: (_) {
        if (homeState.isLoading) return Text(S.of(context).getting_data_text);
        if (homeState.weather == null) return Container();
        List<AdditionalWeatherInfo> allAdditionalWeatherInfo =
            AdditionalWeatherInfo.getAllAdditionalWeatherInfo(
                homeState: homeState, context: context);
        return GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 0, 8.h),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allAdditionalWeatherInfo.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            childAspectRatio: 4,
          ),
          itemBuilder: (BuildContext context, int index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                allAdditionalWeatherInfo[index].title,
                style: Styling.transparentTitleTextStyle(context),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                allAdditionalWeatherInfo[index].info,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _CheckAnotherDaysWeatherBtn extends StatelessWidget {
  final HomeState homeState;
  const _CheckAnotherDaysWeatherBtn({Key? key, required this.homeState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (homeState.isLoading) return Container();
        if (homeState.weather == null) return Container();
        return ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              )),
              builder: (context) {
                return OtherDaysWeatherBottomSheet.otherDaysWeatherBottomSheet(
                    context, homeState.weather!.dailyWeatherList);
              },
            );
          },
          child: Text(
            S.of(context).home_screen_forecast_4days_text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white
                .withOpacity(Styling.almostTransparentContainerOpacity()),
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.r),
            ),
          ),
        );
      },
    );
  }
}

class _TransparentContainer extends StatelessWidget {
  final Widget child;
  const _TransparentContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.white
              .withOpacity(Styling.almostTransparentContainerOpacity()),
        ),
        child: child);
  }
}
