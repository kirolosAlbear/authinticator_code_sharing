import 'package:code_grapper/imports.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'register_admin_state.g.dart';

@CopyWith()
class RegisterAdminState extends ParentState {
  ProfileResponseModel? profileResponseModel;

  RegisterAdminState({
    this.profileResponseModel,
    super.status = Status.success,
  }) : super();

  @override
  List<Object?> get props => [profileResponseModel];
}
