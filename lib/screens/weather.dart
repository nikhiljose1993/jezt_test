import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test/model/weather_data_modal.dart';
import 'package:test/providers/weather_provider.dart';
import 'package:test/service/service.dart';
import 'package:test/widgets/weather_skelton.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() {
    return _WeatherScreenState();
  }
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  bool _isLoading = false;
  bool _disposed = false;

  Future<void> _fetchWeatherData() async {
    setState(() {
      _isLoading = true;
    });
    final bool loading =
        await ref.read(weatherDataProvider.notifier).fetchWeatherData();
    if (!_disposed && mounted) {
      setState(() {
        _isLoading = loading;
      });
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    _fetchWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WeatherData weatherData = ref.watch(weatherDataProvider);
    final theme = Theme.of(context);

    final textStyle = TextStyle(
        color: theme.colorScheme.onTertiaryContainer.withAlpha(200),
        fontWeight: FontWeight.w500);

    return _isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.transparent,
            direction: ShimmerDirection.ltr,
            child: const WeatherSkelton())
        : Container(
            margin: const EdgeInsets.only(top: 20, left: 8, right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.primaryContainer,
                  theme.colorScheme.tertiaryContainer.withAlpha(180),
                ],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Weather',
                      style: TextStyle(
                          fontSize: 36,
                          color: theme.colorScheme.onPrimaryContainer
                              .withAlpha(200)),
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Now',
                            style: TextStyle(
                                fontSize: 18,
                                color: theme.colorScheme.onPrimaryContainer
                                    .withAlpha(180),
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                '${weatherData.temp.round().toString()}°',
                                style: TextStyle(
                                  fontSize: 36,
                                  color: theme.colorScheme.onTertiaryContainer,
                                ),
                              ),
                              Semantics(
                                label: 'Weather Icon',
                                child: Image.network(
                                  'https://openweathermap.org/img/wn/${weatherData.weatherIcon}@2x.png',
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return const Text('Error');
                                  },
                                  fit: BoxFit.contain,
                                  height: 60,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('Feels like  ', style: textStyle),
                              Text(
                                  '${weatherData.feelsLike.round().toString()}°',
                                  style: textStyle),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Min  ', style: textStyle),
                              Text('${weatherData.tempMin.round().toString()}°',
                                  style: textStyle),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Max ', style: textStyle),
                              Text(
                                  '${weatherData.tempMax.round().toString()}°'),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: theme.colorScheme.secondary,
                              ),
                              Text(' ${weatherData.name}', style: textStyle),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text('Wind: ', style: textStyle),
                              Text(
                                  '${(weatherData.windSpeed * 3.6).round()} kmph',
                                  style: textStyle),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text('Humidity: ', style: textStyle),
                              Text('${weatherData.humidity}%',
                                  style: textStyle),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text('Sunrise: ', style: textStyle),
                              Text(
                                  Services().epochTo12HourTime(
                                      weatherData.sysSunrise),
                                  style: textStyle),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text('Sunset: ', style: textStyle),
                              Text(
                                  Services()
                                      .epochTo12HourTime(weatherData.sysSunset),
                                  style: textStyle),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                              Services()
                                  .epochToCustomDateFormat(weatherData.dt),
                              style: textStyle)
                        ],
                      )
                    ]),
              ],
            ),
          );
  }
}
