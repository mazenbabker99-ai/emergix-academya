import {
  AdminGetMembershipSettingsResponse,
  AdminGrantUserCourseAccessBody,
  AdminListUserCourseAccessResponseItem,
  AdminCreateMembershipPlanBody,
  AdminUpdateMembershipSettingsBody,
  ListMembershipOffersResponse,
} from "./generated/api";

export * from "./generated/api";
export * from "./generated/types";
export * as generatedTypes from "./generated/types";

export const AdminMembershipResponse = AdminGetMembershipSettingsResponse;
export const CourseAccessGrant = AdminListUserCourseAccessResponseItem;
export const GrantCourseAccessInput = AdminGrantUserCourseAccessBody;
export const MembershipPlanInput = AdminCreateMembershipPlanBody;
export const MembershipSettingsInput = AdminUpdateMembershipSettingsBody;
export const MembershipOffersResponse = ListMembershipOffersResponse;
