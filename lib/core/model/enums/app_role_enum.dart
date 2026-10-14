enum AppRoleEnum { student, teacher, user }

AppRoleEnum mapStringToRole(String role) {
  return AppRoleEnum.values.firstWhere(
    (e) => e.name.toLowerCase() == role.toLowerCase(),
    orElse: () => AppRoleEnum.user,
  );
}
