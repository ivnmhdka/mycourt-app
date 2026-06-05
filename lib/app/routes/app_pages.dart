import 'package:get/get.dart';

import '../modules/AdminBooking/bindings/admin_booking_binding.dart';
import '../modules/AdminBooking/views/admin_booking_view.dart';
import '../modules/AdminDashboard/bindings/admin_dashboard_binding.dart';
import '../modules/AdminDashboard/views/admin_dashboard_view.dart';
import '../modules/AppDashboard/bindings/app_dashboard_binding.dart';
import '../modules/AppDashboard/views/app_dashboard_view.dart';
import '../modules/Booking/bindings/booking_binding.dart';
import '../modules/Booking/views/booking_view.dart';
import '../modules/FieldDetail/bindings/field_detail_binding.dart';
import '../modules/FieldDetail/views/field_detail_view.dart';
import '../modules/ManagerDashboard/bindings/manager_dashboard_binding.dart';
import '../modules/ManagerDashboard/views/manager_dashboard_view.dart';
import '../modules/SportFields/bindings/sport_fields_binding.dart';
import '../modules/SportFields/views/sport_fields_view.dart';
import '../modules/UserManagement/bindings/user_management_binding.dart';
import '../modules/UserManagement/views/user_management_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.APP_DASHBOARD,
      page: () => AppDashboardView(),
      binding: AppDashboardBinding(),
    ),
    GetPage(
      name: _Paths.SPORT_FIELDS,
      page: () => const SportFieldsView(),
      binding: SportFieldsBinding(),
    ),
    GetPage(
      name: _Paths.FIELD_DETAIL,
      page: () => const FieldDetailView(),
      binding: FieldDetailBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.USER_MANAGEMENT,
      page: () => const UserManagementView(),
      binding: UserManagementBinding(),
    ),
    GetPage(
      name: _Paths.MANAGER_DASHBOARD,
      page: () => const ManagerDashboardView(),
      binding: ManagerDashboardBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_BOOKING,
      page: () => const AdminBookingView(),
      binding: AdminBookingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
  ];
}
