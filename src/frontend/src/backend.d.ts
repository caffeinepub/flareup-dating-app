import type { Principal } from "@icp-sdk/core/principal";
export interface Some<T> {
    __kind__: "Some";
    value: T;
}
export interface None {
    __kind__: "None";
}
export type Option<T> = Some<T> | None;
export interface Location {
    latitude: number;
    country: string;
    city: string;
    longitude: number;
}
export interface LogonActivity {
    logon: string;
    timestamp: Time;
}
export type Time = bigint;
export interface Upgrade {
    id: string;
    user: Principal;
    description: string;
    timestamp: Time;
}
export interface SocialMediaLink {
    url: string;
    platform: string;
}
export interface Profile {
    age?: bigint;
    bio?: string;
    diamonds: bigint;
    createdAt: Time;
    coins: bigint;
    upgrades: Array<Upgrade>;
    email?: string;
    hasAgreedToTerms: boolean;
    socialMediaLinks: Array<SocialMediaLink>;
    logonActivity: Array<LogonActivity>;
    avatarUrl?: string;
    birthday?: Time;
    interestedIn?: string;
    gender: string;
    lastActive: bigint;
    location?: Location;
    photos: Array<string>;
    firstName: string;
}
export interface Agency {
    id: string;
    creator: Principal;
    members: Array<Principal>;
    name: string;
    description?: string;
    createdTimestamp: Time;
    isValid: boolean;
}
export enum UserRole {
    admin = "admin",
    user = "user",
    guest = "guest"
}
export interface backendInterface {
    acceptMembershipRequest(memberName: string): Promise<void>;
    assignCallerUserRole(user: Principal, role: UserRole): Promise<void>;
    createAgency(name: string, description: string | null): Promise<Agency>;
    creditWallet(amountCoins: bigint, amountDiamonds: bigint): Promise<void>;
    debitWallet(amountCoins: bigint, amountDiamonds: bigint): Promise<void>;
    getCallerUserProfile(): Promise<Profile | null>;
    getCallerUserRole(): Promise<UserRole>;
    getUserProfile(user: Principal): Promise<Profile | null>;
    isCallerAdmin(): Promise<boolean>;
    joinAgency(agencyId: string): Promise<void>;
    registerProfile(firstName: string, gender: string): Promise<Profile>;
    requestMembership(memberName: string, description: string): Promise<void>;
    saveCallerUserProfile(profile: Profile): Promise<void>;
}
