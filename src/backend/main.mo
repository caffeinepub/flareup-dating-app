import Map "mo:core/Map";
import Set "mo:core/Set";
import Runtime "mo:core/Runtime";
import Principal "mo:core/Principal";
import Nat "mo:core/Nat";
import Array "mo:core/Array";
import Iter "mo:core/Iter";
import Time "mo:core/Time";
import Order "mo:core/Order";
import List "mo:core/List";
import Text "mo:core/Text";
import AccessControl "authorization/access-control";
import MixinAuthorization "authorization/MixinAuthorization";

actor {
  // Authorization System Integration
  let accessControlState = AccessControl.initState();
  include MixinAuthorization(accessControlState);

  // Types
  module Profile {
    public func compare(p1 : Profile, p2 : Profile) : Order.Order {
      switch (Text.compare(p1.firstName, p2.firstName)) {
        case (#equal) { Text.compare(p1.gender, p2.gender) };
        case (order) { order };
      };
    };
  };

  public type Profile = {
    firstName : Text;
    createdAt : Time.Time;
    email : ?Text;
    birthday : ?Time.Time;
    age : ?Nat;
    gender : Text;
    coins : Nat;
    diamonds : Nat;
    logonActivity : [LogonActivity];
    upgrades : [Upgrade];
    bio : ?Text;
    location : ?Location;
    interestedIn : ?Text;
    photos : [Text];
    socialMediaLinks : [SocialMediaLink];
    hasAgreedToTerms : Bool;
    lastActive : Int;
    avatarUrl : ?Text;
  };

  module ProfileUpdate {
    public func compareByFirstName(p1 : ProfileUpdate, p2 : ProfileUpdate) : Order.Order {
      Text.compare(p1.firstName, p2.firstName);
    };
  };

  type ProfileUpdate = {
    firstName : Text;
    createdAt : Time.Time;
    sender : Principal;
    isValid : Bool;
    updateType : Text;
  };

  module Message {
    public func compare(m1 : Message, m2 : Message) : Order.Order {
      Nat.compare(m1.timestamp, m2.timestamp);
    };
  };

  type Message = {
    messageID : Text;
    text : ?Text;
    sender : Principal;
    receiver : Principal;
    timestamp : Nat;
    isValid : Bool;
  };

  module Gift {
    public func compare(g1 : Gift, g2 : Gift) : Order.Order {
      g1.giverId.toText().compare(g2.giverId.toText());
    };
  };

  type Gift = {
    id : Text;
    title : Text;
    price : Nat;
    isValid : Bool;
    giverId : Principal;
    receiverId : Principal;
    timestamp : Nat;
  };

  module Subscription {
    public func compare(s1 : Subscription, s2 : Subscription) : Order.Order {
      switch (Text.compare(s1.subscriptionType, s2.subscriptionType)) {
        case (#equal) { Text.compare(s1.subscriptionId, s2.subscriptionId) };
        case (order) { order };
      };
    };
  };

  type Subscription = {
    subscriptionId : Text;
    userId : Principal;
    startTime : Time.Time;
    endTime : Time.Time;
    amount : Nat;
    subscriptionType : Text;
    isActive : Bool;
  };

  module LiveSession {
    public func compare(l1 : LiveSession, l2 : LiveSession) : Order.Order {
      Nat.compare(l1.sessionId, l2.sessionId);
    };
  };

  type LiveSession = {
    sessionId : Nat;
    host : Principal;
    viewer : Principal;
    startTimestamp : Time.Time;
    isValid : Bool;
  };

  // Agency/Family Group System
  module Agency {
    public func compareByName(a1 : Agency, a2 : Agency) : Order.Order {
      switch (Text.compare(a1.name, a2.name)) {
        case (#equal) { Text.compare(a1.creator.toText(), a2.creator.toText()) };
        case (order) { order };
      };
    };
  };

  // Agency/Family Group System
  type Agency = {
    id : Text;
    name : Text;
    description : ?Text;
    creator : Principal;
    members : [Principal];
    createdTimestamp : Time.Time;
    isValid : Bool;
  };

  module Invitation {
    public func compareByDiscription(i1 : Invitation, i2 : Invitation) : Order.Order {
      Text.compare(i1.description, i2.description);
    };
  };

  type Invitation = {
    id : Text;
    agencyId : Text;
    inviter : Principal;
    invitee : Principal;
    timestamp : Time.Time;
    isValid : Bool;
    description : Text;
  };

  module Upgrade {
    public func compareByDescription(u1 : Upgrade, u2 : Upgrade) : Order.Order {
      Text.compare(u1.description, u2.description);
    };
  };

  type Upgrade = {
    id : Text;
    user : Principal;
    timestamp : Time.Time;
    description : Text;
  };

  module SystemUpdate {
    public func compareByTitle(s1 : SystemUpdate, s2 : SystemUpdate) : Order.Order {
      Text.compare(s1.title, s2.title);
    };
  };

  type SystemUpdate = {
    id : Text;
    timestamp : Time.Time;
    title : Text;
    description : Text;
  };

  type LogonActivity = {
    logon : Text;
    timestamp : Time.Time;
  };

  type MaintainanceStatus = {
    id : Text;
    timestamp : Time.Time;
    isValid : Bool;
    description : Text;
  };

  type TopUp = {
    user : Principal;
    timestamp : Time.Time;
    amountCoins : Nat;
    amountDiamonds : Nat;
    isValid : Bool;
  };

  type Location = {
    city : Text;
    country : Text;
    latitude : Float;
    longitude : Float;
  };

  type SocialMediaLink = {
    platform : Text;
    url : Text;
  };

  type Streamer = {
    profile : Profile;
    streamTitle : Text;
    isLive : Bool;
    likes : Nat;
    viewers : [Principal];
    onlineDuration : Int;
  };

  module AgencyMemberRequest {
    public func compare(m1 : AgencyMemberRequest, m2 : AgencyMemberRequest) : Order.Order {
      m1.memberName.compare(m2.memberName);
    };
  };

  type AgencyMemberRequest = {
    memberName : Text;
    timestamp : Time.Time;
    sender : Principal;
    isValid : Bool;
    description : Text;
  };

  module Product {
    public func compareByTitle(p1 : Product, p2 : Product) : Order.Order {
      Text.compare(p1.title, p2.title);
    };
  };

  type Product = {
    id : Text;
    title : Text;
    price : Nat;
    description : Text;
    isService : Bool;
  };

  // State
  let profiles = Map.empty<Principal, Profile>();
  let deletedProfiles = Set.empty<Principal>();
  let sentMessages = Map.empty<Principal, [Message]>();
  let tempSentMessages = Map.empty<Principal, [Message]>();
  let gifts = Map.empty<Text, Gift>();
  let tempGifts = Map.empty<Text, Gift>();
  let topUps = Map.empty<Text, TopUp>();
  let subscriptions = Map.empty<Principal, Subscription>();
  let tempSubscriptions = Map.empty<Text, Subscription>();
  let liveSessions = Map.empty<Nat, LiveSession>();
  let tempLiveSessions = Map.empty<Nat, LiveSession>();
  let productStore = Map.empty<Text, [Product]>();
  let agencies = Map.empty<Text, Agency>();
  let tempAgencies = Map.empty<Text, Agency>();
  let memberRequests = Map.empty<Text, [AgencyMemberRequest]>();
  let tempMemberRequests = Map.empty<Text, [AgencyMemberRequest]>();
  let invitations = Map.empty<Text, Invitation>();
  let tempInvitations = Map.empty<Text, Invitation>();
  let upgrades = Map.empty<Text, Upgrade>();
  let tempUpgrades = Map.empty<Text, Upgrade>();
  let systemUpdates = Map.empty<Text, SystemUpdate>();
  let maintainance = Map.empty<Text, MaintainanceStatus>();
  let recentlyAdded = Map.empty<Nat, Profile>();
  let recentlyAddedCounter = Map.empty<Nat, Profile>();
  let activeUsersToday = Map.empty<Principal, Profile>();
  let streamerStore = Map.empty<Principal, Streamer>();
  let tempStreamerStore = Map.empty<Principal, Streamer>();
  let countryStats = Map.empty<Text, Nat>();

  let groupMessages = Map.empty<Text, [Message]>();
  let tempGroupMessages = Map.empty<Text, [Message]>();
  let groupMembershipRequests = Map.empty<Text, [Principal]>();
  let tempGroupMembershipRequests = Map.empty<Text, [Principal]>();

  let searchStore = Map.empty<Principal, Profile>();
  let tempSearchStore = Map.empty<Principal, Profile>();
  let searchHistory = Map.empty<Principal, [Text]>();
  let cachedSearchResults = Map.empty<Text, [Profile]>();

  let websiteSettings = Map.empty<Text, Text>();
  let notifications = Map.empty<Principal, [Text]>();
  let paymentTransactions = Map.empty<Principal, [Product]>();
  let favorites = Map.empty<Principal, Set.Set<Principal>>();
  let tempFavorites = Map.empty<Principal, Set.Set<Principal>>();
  let blockList = Map.empty<Principal, Set.Set<Principal>>();
  let tempBlockList = Map.empty<Principal, Set.Set<Principal>>();
  let reportStore = Map.empty<Text, Text>();
  let privacySettings = Map.empty<Principal, Map.Map<Text, Text>>();
  let verificationRequests = Map.empty<Principal, Text>();
  let dailyChallenges = Map.empty<Principal, [Text]>();
  let completedChallenges = Map.empty<Principal, [Text]>();
  let sentGifts = Map.empty<Principal, [Gift]>();
  let tempSentGifts = Map.empty<Principal, [Gift]>();
  let incomingGifts = Map.empty<Principal, [Gift]>();
  let eventStore = Map.empty<Text, (Text, [Principal])>();
  let tempEventStore = Map.empty<Text, (Text, [Principal])>();
  let eventRegistrations = Map.empty<Text, [Principal]>();
  let tempEventRegistrations = Map.empty<Text, [Principal]>();
  let feedbackStore = Map.empty<Principal, [Text]>();
  let adminStore = Map.empty<Principal, Profile>();
  let tempAdminStore = Map.empty<Principal, Profile>();
  let notificationsSettings = Map.empty<Principal, Map.Map<Text, Bool>>();
  let tutorialProgress = Map.empty<Principal, Nat>();

  let ratingsSuppliers = Map.empty<Principal, Nat>();
  let agencyApplications = Map.empty<Text, (Principal, Text)>();
  let assignmentTrackTerminal = Map.empty<Principal, Text>();

  let interviewTrackTerminal = Map.empty<Text, [Text]>();
  let businessCommunication = Map.empty<Text, (Principal, Text)>();
  let personalCommunication = Map.empty<Text, (Principal, Text)>();
  let timeManagement = Map.empty<Principal, Nat>();
  let attendanceTrackTerminal = Map.empty<Principal, Nat>();
  let performanceReview = Map.empty<Principal, Nat>();
  let payRoll = Map.empty<Principal, Nat>();
  let kpiStore = Map.empty<Principal, Nat>();

  // Required profile management functions
  public query ({ caller }) func getCallerUserProfile() : async ?Profile {
    if (not (AccessControl.hasPermission(accessControlState, caller, #user))) {
      Runtime.trap("Unauthorized: Only users can view profiles");
    };
    profiles.get(caller);
  };

  public query ({ caller }) func getUserProfile(user : Principal) : async ?Profile {
    if (caller != user and not AccessControl.isAdmin(accessControlState, caller)) {
      Runtime.trap("Unauthorized: Can only view your own profile");
    };
    profiles.get(user);
  };

  public shared ({ caller }) func saveCallerUserProfile(profile : Profile) : async () {
    if (not (AccessControl.hasPermission(accessControlState, caller, #user))) {
      Runtime.trap("Unauthorized: Only users can save profiles");
    };
    profiles.add(caller, profile);
  };

  // Profile Registration
  public shared ({ caller }) func registerProfile(firstName : Text, gender : Text) : async Profile {
    if (not (AccessControl.hasPermission(accessControlState, caller, #user))) {
      Runtime.trap("Unauthorized: Only users can register profiles");
    };

    let newProfile : Profile = {
      firstName;
      gender;
      createdAt = Time.now();
      email = null;
      birthday = null;
      age = null;
      coins = 20_000;
      diamonds = 20_000;
      logonActivity = [];
      upgrades = [];
      bio = null;
      location = null;
      interestedIn = null;
      photos = [];
      socialMediaLinks = [];
      hasAgreedToTerms = false;
      lastActive = 0;
      avatarUrl = null;
    };

    profiles.add(caller, newProfile);
    newProfile;
  };

  // Credit Wallet - only the wallet owner can credit their own wallet
  public shared ({ caller }) func creditWallet(amountCoins : Nat, amountDiamonds : Nat) : async () {
    if (not (AccessControl.hasPermission(accessControlState, caller, #user))) {
      Runtime.trap("Unauthorized: Only users can credit wallets");
    };

    if (amountCoins <= 0 and amountDiamonds <= 0) {
      Runtime.trap("Amount must be greater than 0");
    };

    switch (profiles.get(caller)) {
      case (null) { Runtime.trap("Profile not found") };
      case (?profile) {
        let newProfile : Profile = {
          profile with
          coins = profile.coins + amountCoins;
          diamonds = profile.diamonds + amountDiamonds;
        };
        profiles.add(caller, newProfile);
      };
    };
  };

  // Debit Wallet - only the wallet owner can debit their own wallet
  public shared ({ caller }) func debitWallet(amountCoins : Nat, amountDiamonds : Nat) : async () {
    if (not (AccessControl.hasPermission(accessControlState, caller, #user))) {
      Runtime.trap("Unauthorized: Only users can debit wallets");
    };

    if (amountCoins <= 0 and amountDiamonds <= 0) {
      Runtime.trap("Amount must be greater than 0");
    };

    switch (profiles.get(caller)) {
      case (null) { Runtime.trap("Profile not found") };
      case (?profile) {
        if (profile.coins < amountCoins or profile.diamonds < amountDiamonds) {
          Runtime.trap("Insufficient balance");
        };

        let newProfile : Profile = {
          profile with
          coins = profile.coins - amountCoins;
          diamonds = profile.diamonds - amountDiamonds;
        };
        profiles.add(caller, newProfile);
      };
    };
  };

  // Create Agency/Family - only users can create agencies
  public shared ({ caller }) func createAgency(name : Text, description : ?Text) : async Agency {
    if (not (AccessControl.hasPermission(accessControlState, caller, #user))) {
      Runtime.trap("Unauthorized: Only users can create agencies");
    };

    let id = name;
    let newAgency : Agency = {
      id;
      name;
      description;
      creator = caller;
      members = [caller];
      createdTimestamp = Time.now();
      isValid = true;
    };

    agencies.add(id, newAgency);
    newAgency;
  };

  // Add Agency With Logical Program - internal function, no authorization needed
  func addAgencyWithMemo(name : Text, description : ?Text, creator : Principal) : () {
    if (not agencies.containsKey(name)) {
      let newAgency : Agency = {
        id = name;
        name;
        description;
        creator;
        members = [creator];
        createdTimestamp = Time.now();
        isValid = true;
      };
      agencies.add(name, newAgency);
    };
  };

  // Join Agency/Family - only users can join agencies
  public shared ({ caller }) func joinAgency(agencyId : Text) : async () {
    if (not (AccessControl.hasPermission(accessControlState, caller, #user))) {
      Runtime.trap("Unauthorized: Only users can join agencies");
    };

    switch (agencies.get(agencyId)) {
      case (null) { Runtime.trap("Agency not found") };
      case (?agency) {
        if (agency.members.find(func(member) { member == caller }) != null) {
          Runtime.trap("You are already a member of this agency");
        };
        let newAgency : Agency = {
          agency with
          members = agency.members.concat([caller]);
        };
        agencies.add(agencyId, newAgency);
      };
    };
  };

  // Request Membership in Agency/Family - only users can request membership
  public shared ({ caller }) func requestMembership(memberName : Text, description : Text) : async () {
    if (not (AccessControl.hasPermission(accessControlState, caller, #user))) {
      Runtime.trap("Unauthorized: Only users can request membership");
    };

    let request : AgencyMemberRequest = {
      memberName;
      timestamp = Time.now();
      sender = caller;
      isValid = true;
      description;
    };

    let existingRequests = switch (memberRequests.get(memberName)) {
      case (null) { [] };
      case (?requests) { requests };
    };
    let newRequests = existingRequests.concat([request]);
    memberRequests.add(memberName, newRequests);
  };

  // Accept Membership Request - only agency creator or admin can accept
  public shared ({ caller }) func acceptMembershipRequest(memberName : Text) : async () {
    if (not (AccessControl.hasPermission(accessControlState, caller, #user))) {
      Runtime.trap("Unauthorized: Only users can accept membership requests");
    };

    switch (agencies.get(memberName)) {
      case (null) { Runtime.trap("Agency not found") };
      case (?agency) {
        // Only the agency creator can accept membership requests
        if (agency.creator != caller and not AccessControl.isAdmin(accessControlState, caller)) {
          Runtime.trap("Unauthorized: Only the agency creator or admin can accept membership requests");
        };

        let requests = switch (memberRequests.get(memberName)) {
          case (null) { Runtime.trap("Request not found") };
          case (?requests) { requests };
        };

        memberRequests.remove(memberName);
        let newAgency : Agency = {
          agency with
          members = agency.members.concat([caller]);
        };
        agencies.add(memberName, newAgency);
      };
    };
  };
};
