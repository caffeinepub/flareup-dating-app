import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { ScrollArea } from "@/components/ui/scroll-area";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { Toaster } from "@/components/ui/sonner";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  ArrowRight,
  Bell,
  Camera,
  CheckCircle,
  ChevronLeft,
  Coins,
  Crown,
  Diamond,
  Eye,
  Flame,
  Gamepad2,
  Gift,
  Heart,
  MapPin,
  MessageCircle,
  Minus,
  Play,
  Plus,
  Send,
  Settings,
  Sparkles,
  Star,
  TrendingUp,
  Trophy,
  User,
  Users,
  Video,
  Wallet,
  X,
  Zap,
} from "lucide-react";
import { AnimatePresence, motion } from "motion/react";
import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useRef,
  useState,
} from "react";
import { toast } from "sonner";

// ── Types ─────────────────────────────────────────────────────────────────────
type Screen =
  | "auth"
  | "home"
  | "wallet"
  | "live"
  | "games"
  | "profile"
  | "chat"
  | "agency"
  | "liveview"
  | "messages";
type Gender = "male" | "female";
type Role = "user" | "host" | "agency";

interface UserState {
  name: string;
  email: string;
  gender: Gender;
  country: string;
  coins: number;
  diamonds: number;
  level: number;
  totalRecharge: number;
  role: Role;
  isPremium: boolean;
  bio: string;
}

interface GameHistory {
  id: number;
  game: string;
  result: string;
  amount: number;
  currency: "coins" | "diamonds";
  timestamp: string;
  won: boolean;
}

interface Message {
  id: number;
  from: string;
  text: string;
  time: string;
  mine: boolean;
}

interface AppContextType {
  user: UserState;
  setUser: (u: UserState) => void;
  screen: Screen;
  setScreen: (s: Screen) => void;
  isLoggedIn: boolean;
  setIsLoggedIn: (v: boolean) => void;
  gameHistory: GameHistory[];
  addGameHistory: (g: GameHistory) => void;
  activeLiveStream: number | null;
  setActiveLiveStream: (id: number | null) => void;
}

// ── Context ───────────────────────────────────────────────────────────────────
const AppContext = createContext<AppContextType | null>(null);
function useApp() {
  const ctx = useContext(AppContext);
  if (!ctx) throw new Error("Missing AppContext");
  return ctx;
}

// ── Mock Data ─────────────────────────────────────────────────────────────────
const mockProfiles = [
  {
    id: 1,
    name: "Sofia",
    age: 24,
    location: "Lagos, Nigeria",
    image: "/assets/generated/profile-sofia.dim_400x500.jpg",
    diamonds: 450,
    role: "user" as Role,
    verified: true,
    hot: true,
  },
  {
    id: 2,
    name: "Amara",
    age: 22,
    location: "Abuja, Nigeria",
    image: "/assets/generated/profile-amara.dim_400x500.jpg",
    diamonds: 1200,
    role: "host" as Role,
    verified: true,
    hot: false,
  },
  {
    id: 3,
    name: "Zara",
    age: 26,
    location: "London, UK",
    image: "/assets/generated/profile-zara.dim_400x500.jpg",
    diamonds: 780,
    role: "user" as Role,
    verified: false,
    hot: true,
  },
  {
    id: 4,
    name: "Chioma",
    age: 23,
    location: "Port Harcourt, Nigeria",
    image: "/assets/generated/profile-sofia.dim_400x500.jpg",
    diamonds: 320,
    role: "user" as Role,
    verified: true,
    hot: false,
  },
  {
    id: 5,
    name: "Nadia",
    age: 25,
    location: "Accra, Ghana",
    image: "/assets/generated/profile-amara.dim_400x500.jpg",
    diamonds: 890,
    role: "host" as Role,
    verified: true,
    hot: true,
  },
];

const mockStreams = [
  {
    id: 1,
    name: "Amara 💫",
    viewers: 1420,
    image: "/assets/generated/profile-amara.dim_400x500.jpg",
    topic: "Evening Vibes 🌙",
    gifts: 340,
  },
  {
    id: 2,
    name: "Sofia 🌸",
    viewers: 876,
    image: "/assets/generated/profile-sofia.dim_400x500.jpg",
    topic: "Chill & Chat ☕",
    gifts: 120,
  },
  {
    id: 3,
    name: "Nadia ✨",
    viewers: 2100,
    image: "/assets/generated/profile-zara.dim_400x500.jpg",
    topic: "Dance Party 🎵",
    gifts: 560,
  },
  {
    id: 4,
    name: "Chioma 🔥",
    viewers: 650,
    image: "/assets/generated/profile-amara.dim_400x500.jpg",
    topic: "Q&A Session 💬",
    gifts: 88,
  },
];

const giftItems = [
  { id: 1, name: "Rose", icon: "🌹", cost: 10, currency: "coins" as const },
  {
    id: 2,
    name: "Chocolate",
    icon: "🍫",
    cost: 50,
    currency: "coins" as const,
  },
  { id: 3, name: "Ring", icon: "💍", cost: 200, currency: "coins" as const },
  { id: 4, name: "Crown", icon: "👑", cost: 500, currency: "coins" as const },
  { id: 5, name: "Rocket", icon: "🚀", cost: 1000, currency: "coins" as const },
  { id: 6, name: "Flame", icon: "🔥", cost: 2000, currency: "coins" as const },
];

const gamesList = [
  {
    id: 1,
    name: "Lucky Spin",
    icon: "🎰",
    cost: 50,
    currency: "coins" as const,
    color: "from-purple-500 to-indigo-600",
    reward: [0, 100, 200, 300],
  },
  {
    id: 2,
    name: "Diamond Rush",
    icon: "💎",
    cost: 100,
    currency: "diamonds" as const,
    color: "from-cyan-400 to-blue-600",
    reward: [0, 100, 200, 500],
  },
  {
    id: 3,
    name: "Coin Flip",
    icon: "🪙",
    cost: 20,
    currency: "coins" as const,
    color: "from-yellow-400 to-orange-500",
    reward: [0, 40, 0, 40],
  },
  {
    id: 4,
    name: "Love Slots",
    icon: "🎡",
    cost: 80,
    currency: "coins" as const,
    color: "from-pink-500 to-rose-600",
    reward: [0, 160, 240, 400],
  },
  {
    id: 5,
    name: "Treasure Hunt",
    icon: "🗺️",
    cost: 150,
    currency: "coins" as const,
    color: "from-emerald-400 to-teal-600",
    reward: [0, 300, 450, 750],
  },
  {
    id: 6,
    name: "Fire Blast",
    icon: "🌋",
    cost: 200,
    currency: "diamonds" as const,
    color: "from-red-500 to-orange-600",
    reward: [100, 200, 400, 1000],
  },
];

const mockMessages: Message[] = [
  {
    id: 1,
    from: "Sofia",
    text: "Hey! Loved your profile 😍",
    time: "2:30 PM",
    mine: false,
  },
  {
    id: 2,
    from: "You",
    text: "Thank you! You're amazing 🔥",
    time: "2:31 PM",
    mine: true,
  },
  {
    id: 3,
    from: "Sofia",
    text: "When are we meeting? 😊",
    time: "2:32 PM",
    mine: false,
  },
  {
    id: 4,
    from: "You",
    text: "This weekend? I know a great spot!",
    time: "2:33 PM",
    mine: true,
  },
  {
    id: 5,
    from: "Sofia",
    text: "Sounds perfect! Can't wait 💕",
    time: "2:34 PM",
    mine: false,
  },
];

const mockAgencyMembers = [
  {
    id: 1,
    name: "Amara",
    role: "host" as Role,
    avatar: "/assets/generated/profile-amara.dim_400x500.jpg",
  },
  {
    id: 2,
    name: "Sofia",
    role: "user" as Role,
    avatar: "/assets/generated/profile-sofia.dim_400x500.jpg",
  },
  {
    id: 3,
    name: "Zara",
    role: "host" as Role,
    avatar: "/assets/generated/profile-zara.dim_400x500.jpg",
  },
  {
    id: 4,
    name: "Nadia",
    role: "host" as Role,
    avatar: "/assets/generated/profile-amara.dim_400x500.jpg",
  },
];

// ── Helpers ───────────────────────────────────────────────────────────────────
function GradientButton({
  children,
  onClick,
  className = "",
  disabled = false,
  "data-ocid": ocid = "",
}: {
  children: React.ReactNode;
  onClick?: () => void;
  className?: string;
  disabled?: boolean;
  "data-ocid"?: string;
}) {
  return (
    <button
      type="button"
      data-ocid={ocid}
      onClick={onClick}
      disabled={disabled}
      className={`flare-gradient-soft text-white font-bold rounded-full px-6 py-3 shadow-card transition-all active:scale-95 hover:shadow-glow disabled:opacity-50 disabled:cursor-not-allowed ${className}`}
    >
      {children}
    </button>
  );
}

function CoinBadge({ amount }: { amount: number }) {
  return (
    <span className="inline-flex items-center gap-1 text-yellow-500 font-bold">
      <span>🪙</span>
      {amount.toLocaleString()}
    </span>
  );
}
function DiamondBadge({ amount }: { amount: number }) {
  return (
    <span className="inline-flex items-center gap-1 text-cyan-500 font-bold">
      <span>💎</span>
      {amount.toLocaleString()}
    </span>
  );
}

// ── Auth Screen ───────────────────────────────────────────────────────────────
function AuthScreen() {
  const { setIsLoggedIn, setScreen, setUser, user } = useApp();
  const [mode, setMode] = useState<"login" | "signup">("login");
  const [form, setForm] = useState({
    email: "",
    password: "",
    name: "",
    gender: "male" as Gender,
    country: "Nigeria",
  });
  const [loading, setLoading] = useState(false);

  const handleSubmit = async () => {
    if (!form.email || !form.password) {
      toast.error("Please fill all fields");
      return;
    }
    if (mode === "signup" && !form.name) {
      toast.error("Please enter your name");
      return;
    }
    if (form.password.length < 4) {
      toast.error("Password is too short — must be exactly 6 characters");
      return;
    }
    if (form.password.length !== 6) {
      toast.error("Password must be exactly 6 characters (letters + numbers)");
      return;
    }
    if (mode === "signup") {
      const pw = form.password;
      const hasLetter = /[a-zA-Z]/.test(pw);
      const hasDigit = /[0-9]/.test(pw);
      if (!hasLetter || !hasDigit) {
        toast.error("Password must contain both letters and numbers");
        return;
      }
    }
    setLoading(true);
    await new Promise((r) => setTimeout(r, 900));
    setUser({
      ...user,
      name: form.name || "FlareUser",
      email: form.email,
      gender: form.gender,
      country: form.country,
      coins: 0,
      diamonds: 200,
    });
    setIsLoggedIn(true);
    setScreen("home");
    toast.success(`Welcome${form.name ? ` ${form.name}` : ""} 🔥`);
    setLoading(false);
  };

  return (
    <div className="min-h-screen w-full flare-gradient flex flex-col items-center justify-center relative overflow-hidden">
      {/* Decorative blobs */}
      <div
        className="absolute top-[-80px] right-[-80px] w-64 h-64 rounded-full opacity-20"
        style={{ background: "radial-gradient(circle, #FF8A00, transparent)" }}
      />
      <div
        className="absolute bottom-[-60px] left-[-60px] w-48 h-48 rounded-full opacity-20"
        style={{ background: "radial-gradient(circle, #FF2B7A, transparent)" }}
      />

      <motion.div
        initial={{ opacity: 0, y: -30 }}
        animate={{ opacity: 1, y: 0 }}
        className="text-center mb-8"
      >
        <div className="w-20 h-20 mx-auto mb-3 rounded-full bg-white/20 flex items-center justify-center shadow-glow">
          <img
            src="/assets/generated/flareup-logo-transparent.dim_200x200.png"
            alt="FlareUp"
            className="w-14 h-14 object-contain"
          />
        </div>
        <h1 className="text-4xl font-black text-white tracking-tight">
          FlareUp
        </h1>
        <p className="text-white/80 text-sm font-medium mt-1">
          ✨ Light Up Your Love ✨
        </p>
      </motion.div>

      <motion.div
        initial={{ opacity: 0, y: 30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.15 }}
        className="w-full max-w-sm mx-4 bg-white/10 backdrop-blur-md rounded-3xl p-6 shadow-2xl border border-white/20"
      >
        {/* Toggle */}
        <div className="flex bg-white/20 rounded-full p-1 mb-6">
          {(["login", "signup"] as const).map((m) => (
            <button
              type="button"
              key={m}
              data-ocid={`auth.${m}_tab`}
              onClick={() => setMode(m)}
              className={`flex-1 rounded-full py-2 text-sm font-bold transition-all ${
                mode === m ? "bg-white text-flare-pink shadow" : "text-white"
              }`}
            >
              {m === "login" ? "Login" : "Sign Up"}
            </button>
          ))}
        </div>

        <div className="space-y-3">
          {mode === "signup" && (
            <>
              <Input
                data-ocid="auth.name_input"
                placeholder="Your Name"
                value={form.name}
                onChange={(e) =>
                  setForm((p) => ({ ...p, name: e.target.value }))
                }
                className="rounded-full border-white/30 bg-white/20 text-white placeholder:text-white/60 focus:border-white"
              />
              <div className="grid grid-cols-2 gap-3">
                <select
                  data-ocid="auth.gender_select"
                  value={form.gender}
                  onChange={(e) =>
                    setForm((p) => ({ ...p, gender: e.target.value as Gender }))
                  }
                  className="rounded-full border border-white/30 bg-white/20 text-white px-4 py-2 text-sm focus:outline-none"
                >
                  <option value="male" className="text-black">
                    👨 Male
                  </option>
                  <option value="female" className="text-black">
                    👩 Female
                  </option>
                </select>
                <Input
                  data-ocid="auth.country_input"
                  placeholder="Country"
                  value={form.country}
                  onChange={(e) =>
                    setForm((p) => ({ ...p, country: e.target.value }))
                  }
                  className="rounded-full border-white/30 bg-white/20 text-white placeholder:text-white/60"
                />
              </div>
            </>
          )}
          <Input
            data-ocid="auth.email_input"
            type="email"
            placeholder="Email or Phone"
            value={form.email}
            onChange={(e) => setForm((p) => ({ ...p, email: e.target.value }))}
            className="rounded-full border-white/30 bg-white/20 text-white placeholder:text-white/60 focus:border-white"
          />
          <Input
            data-ocid="auth.password_input"
            type="password"
            placeholder="Password (6 chars, A-Z + 0-9)"
            value={form.password}
            onChange={(e) =>
              setForm((p) => ({ ...p, password: e.target.value }))
            }
            className="rounded-full border-white/30 bg-white/20 text-white placeholder:text-white/60 focus:border-white"
          />
        </div>

        <GradientButton
          data-ocid="auth.submit_button"
          onClick={handleSubmit}
          disabled={loading}
          className="w-full mt-5 py-3.5 text-base"
        >
          {loading
            ? "Loading..."
            : mode === "login"
              ? "🔥 Login"
              : "✨ Create Account"}
        </GradientButton>

        <p className="text-center text-white/60 text-xs mt-4">
          {mode === "login" ? "New here? " : "Already have an account? "}
          <button
            type="button"
            data-ocid="auth.toggle_mode"
            onClick={() => setMode((m) => (m === "login" ? "signup" : "login"))}
            className="text-white font-bold underline"
          >
            {mode === "login" ? "Sign Up" : "Login"}
          </button>
        </p>
      </motion.div>

      <p className="mt-8 text-white/50 text-xs">
        🔥 Female users get free access
      </p>
    </div>
  );
}

// ── Gift Modal ────────────────────────────────────────────────────────────────
function GiftModal({
  open,
  onClose,
  inStream = false,
}: { open: boolean; onClose: () => void; inStream?: boolean }) {
  const { user, setUser } = useApp();
  const [selfGift, setSelfGift] = useState(false);
  const [sentGift, setSentGift] = useState<string | null>(null);

  const sendGift = (gift: (typeof giftItems)[0]) => {
    if (user.coins < gift.cost) {
      toast.error("Not enough coins! 🪙 Recharge in Wallet");
      return;
    }
    setUser({ ...user, coins: user.coins - gift.cost });
    setSentGift(gift.icon);
    toast.success(
      `Sent ${gift.icon} ${gift.name}! ${inStream && gift.cost >= 1000 ? "🔥 Doubles at 12AM!" : ""}`,
    );
    setTimeout(() => setSentGift(null), 2000);
  };

  return (
    <Dialog open={open} onOpenChange={(v) => !v && onClose()}>
      <DialogContent
        data-ocid="gift.modal"
        className="max-w-sm rounded-3xl p-0 overflow-hidden border-0"
      >
        <div className="flare-gradient p-4">
          <DialogHeader>
            <DialogTitle className="text-white text-center text-lg font-black">
              🎁 Send a Gift
            </DialogTitle>
          </DialogHeader>
          <p className="text-white/80 text-center text-xs mt-1">
            Balance: <CoinBadge amount={user.coins} />
          </p>
        </div>
        <div className="p-4 bg-white">
          {inStream && (
            <div className="bg-orange-50 border border-orange-200 rounded-2xl p-2.5 mb-3 text-center">
              <p className="text-orange-600 text-xs font-bold">
                🔥 Send 1000+ coins → Doubles at 12AM!
              </p>
            </div>
          )}
          <div className="grid grid-cols-3 gap-3 mb-4">
            {giftItems.map((g) => (
              <button
                type="button"
                key={g.id}
                data-ocid={`gift.item.${g.id}`}
                onClick={() => sendGift(g)}
                className="flex flex-col items-center bg-secondary/50 rounded-2xl p-2.5 border border-border hover:border-primary transition-all active:scale-95"
              >
                <span className="text-3xl bounce-gift">{g.icon}</span>
                <span className="text-xs font-semibold text-foreground mt-1">
                  {g.name}
                </span>
                <span className="text-xs text-yellow-500 font-bold">
                  🪙{g.cost}
                </span>
              </button>
            ))}
          </div>
          <div className="flex items-center gap-2 bg-secondary/50 rounded-2xl p-3 mb-3">
            <Switch
              checked={selfGift}
              onCheckedChange={setSelfGift}
              id="self-gift"
            />
            <Label
              htmlFor="self-gift"
              className="text-xs font-medium cursor-pointer"
            >
              Gift yourself (doubles at 12AM 🌙)
            </Label>
          </div>
          <Button
            data-ocid="gift.close_button"
            variant="outline"
            className="w-full rounded-full"
            onClick={onClose}
          >
            Close
          </Button>
        </div>
        <AnimatePresence>
          {sentGift && (
            <motion.div
              initial={{ opacity: 1, y: 0, scale: 1 }}
              exit={{ opacity: 0, y: -120, scale: 2 }}
              className="absolute inset-0 flex items-center justify-center pointer-events-none"
            >
              <span className="text-7xl">{sentGift}</span>
            </motion.div>
          )}
        </AnimatePresence>
      </DialogContent>
    </Dialog>
  );
}

// ── Home Screen ───────────────────────────────────────────────────────────────
function HomeScreen() {
  const { user, setScreen } = useApp();
  const [currentIdx, setCurrentIdx] = useState(0);
  const [giftOpen, setGiftOpen] = useState(false);
  const [direction, setDirection] = useState(0);
  const profiles = mockProfiles;

  const handleSkip = () => {
    setDirection(-1);
    setCurrentIdx((i) => (i + 1) % profiles.length);
  };
  const handleLike = () => {
    setDirection(1);
    toast.success(`You liked ${profiles[currentIdx].name}! 💕`);
    setCurrentIdx((i) => (i + 1) % profiles.length);
  };

  const topProfile = profiles[currentIdx];
  const nextProfile = profiles[(currentIdx + 1) % profiles.length];
  const nextNext = profiles[(currentIdx + 2) % profiles.length];

  return (
    <div className="flex flex-col h-full bg-background" data-ocid="home.page">
      {/* Header */}
      <header className="flex items-center justify-between px-4 pt-4 pb-2">
        <div className="flex items-center gap-2">
          <div className="w-8 h-8 flare-gradient rounded-full flex items-center justify-center">
            <Flame className="w-4 h-4 text-white" />
          </div>
          <span className="text-xl font-black flare-gradient-text">
            FlareUp
          </span>
        </div>
        <div className="flex items-center gap-2">
          <div className="flex items-center gap-1 bg-yellow-50 border border-yellow-200 rounded-full px-2 py-1">
            <span className="text-xs">🪙</span>
            <span className="text-xs font-bold text-yellow-600">
              {user.coins.toLocaleString()}
            </span>
          </div>
          <button
            type="button"
            data-ocid="home.notification_button"
            onClick={() => setScreen("messages")}
            className="w-9 h-9 bg-white rounded-full flex items-center justify-center shadow-xs border border-border relative"
          >
            <Bell className="w-4 h-4 text-muted-foreground" />
            <span className="absolute top-1 right-1 w-2 h-2 flare-gradient rounded-full" />
          </button>
        </div>
      </header>

      {/* Swipe Cards */}
      <div className="flex-1 flex flex-col items-center px-4 pt-2 pb-4 overflow-hidden">
        <div className="relative w-full flex-1" style={{ maxHeight: 420 }}>
          {/* Back cards */}
          <div
            className="absolute inset-0 top-4 mx-4 rounded-3xl overflow-hidden shadow"
            style={{
              background: "linear-gradient(135deg, #FF2B7A20, #FF8A0020)",
              transform: "scale(0.94) translateY(8px)",
            }}
          >
            <img
              src={nextNext.image}
              alt={nextNext.name}
              className="w-full h-full object-cover opacity-60"
            />
          </div>
          <div
            className="absolute inset-0 top-2 mx-2 rounded-3xl overflow-hidden shadow-lg"
            style={{ transform: "scale(0.97) translateY(4px)" }}
          >
            <img
              src={nextProfile.image}
              alt={nextProfile.name}
              className="w-full h-full object-cover opacity-80"
            />
          </div>
          {/* Top card */}
          <AnimatePresence mode="wait">
            <motion.div
              key={currentIdx}
              initial={{
                opacity: 0,
                x: direction * 100,
                rotate: direction * 8,
              }}
              animate={{ opacity: 1, x: 0, rotate: 0 }}
              exit={{
                opacity: 0,
                x: direction * -200,
                rotate: direction * -12,
              }}
              transition={{ type: "spring", stiffness: 260, damping: 25 }}
              className="absolute inset-0 rounded-3xl overflow-hidden shadow-2xl cursor-grab"
            >
              <img
                src={topProfile.image}
                alt={topProfile.name}
                className="w-full h-full object-cover"
              />
              {/* Gradient overlay */}
              <div
                className="absolute inset-0"
                style={{
                  background:
                    "linear-gradient(to top, rgba(0,0,0,0.85) 0%, transparent 55%)",
                }}
              />
              {/* Badges */}
              <div className="absolute top-4 left-4 flex gap-2">
                {topProfile.hot && (
                  <span className="bg-orange-500/90 text-white text-xs font-bold px-2 py-1 rounded-full">
                    🔥 Hot
                  </span>
                )}
                {topProfile.verified && (
                  <span className="bg-white/90 text-emerald-600 text-xs font-bold px-2 py-1 rounded-full flex items-center gap-1">
                    <CheckCircle className="w-3 h-3" /> Verified
                  </span>
                )}
                {topProfile.role === "host" && (
                  <span className="flare-gradient text-white text-xs font-bold px-2 py-1 rounded-full">
                    👑 Host
                  </span>
                )}
              </div>
              {/* Info */}
              <div className="absolute bottom-4 left-4 right-4">
                <div className="flex items-end justify-between">
                  <div>
                    <h2 className="text-white text-2xl font-black">
                      {topProfile.name}, {topProfile.age}
                    </h2>
                    <div className="flex items-center gap-1 text-white/80 text-sm mt-0.5">
                      <MapPin className="w-3 h-3" />
                      <span>{topProfile.location}</span>
                    </div>
                  </div>
                  <div className="flex flex-col items-end gap-1">
                    <DiamondBadge amount={topProfile.diamonds} />
                    <div className="flex items-center gap-1 text-yellow-400 text-xs">
                      <Star className="w-3 h-3 fill-yellow-400" />
                      <Star className="w-3 h-3 fill-yellow-400" />
                      <Star className="w-3 h-3 fill-yellow-400" />
                      <Star className="w-3 h-3 fill-yellow-400" />
                      <Star className="w-3 h-3" />
                    </div>
                  </div>
                </div>
              </div>
              {/* Message button */}
              <button
                type="button"
                data-ocid="home.card.message_button"
                onClick={(e) => {
                  e.stopPropagation();
                  setScreen("chat");
                }}
                className="absolute bottom-16 right-4 w-10 h-10 bg-white/20 backdrop-blur-sm border border-white/30 rounded-full flex items-center justify-center"
              >
                <MessageCircle className="w-5 h-5 text-white" />
              </button>
            </motion.div>
          </AnimatePresence>
        </div>

        {/* Action buttons */}
        <div className="flex items-center justify-center gap-8 mt-4">
          <button
            type="button"
            data-ocid="home.skip_button"
            onClick={handleSkip}
            className="w-16 h-16 bg-white rounded-full flex items-center justify-center shadow-card border-2 border-border hover:scale-110 transition-transform active:scale-95"
          >
            <X className="w-7 h-7 text-muted-foreground" />
          </button>
          <button
            type="button"
            data-ocid="home.superlike_button"
            className="w-12 h-12 bg-white rounded-full flex items-center justify-center shadow border border-border hover:scale-110 transition-transform"
          >
            <Star className="w-5 h-5 text-yellow-400 fill-yellow-400" />
          </button>
          <button
            type="button"
            data-ocid="home.like_button"
            onClick={handleLike}
            className="w-16 h-16 rounded-full flex items-center justify-center shadow-card hover:scale-110 transition-transform active:scale-95 flare-gradient-soft"
          >
            <Heart className="w-7 h-7 text-white fill-white" />
          </button>
        </div>

        {/* Nearby scroll */}
        <div className="w-full mt-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm font-bold text-foreground">Nearby 📍</span>
            <button
              type="button"
              data-ocid="home.nearby.see_all_button"
              onClick={() => toast.success("Showing all nearby users 📍")}
              className="text-xs text-primary font-semibold hover:underline"
            >
              See all
            </button>
          </div>
          <div className="flex gap-3 overflow-x-auto pb-1 scrollbar-none">
            {mockProfiles.map((p, i) => (
              <div
                key={p.id}
                data-ocid={`home.nearby.item.${i + 1}`}
                className="flex-shrink-0 flex flex-col items-center gap-1"
              >
                <div className="relative">
                  <div
                    className={`relative w-12 h-12 rounded-full overflow-hidden border-2 ${i % 2 === 0 ? "border-flare-pink" : "border-flare-orange"}`}
                  >
                    <img
                      src={p.image}
                      alt={p.name}
                      className="w-full h-full object-cover"
                    />
                    <div className="absolute bottom-0 right-0 w-3 h-3 bg-emerald-400 border-2 border-white rounded-full" />
                  </div>
                  <button
                    type="button"
                    onClick={() => setScreen("chat")}
                    className="absolute -bottom-0.5 -right-0.5 w-4 h-4 flare-gradient rounded-full flex items-center justify-center border border-white"
                  >
                    <MessageCircle className="w-2 h-2 text-white" />
                  </button>
                </div>
                <span className="text-xs font-medium text-foreground/80 w-12 text-center truncate">
                  {p.name}
                </span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Gift FAB */}
      <button
        type="button"
        data-ocid="home.gift_button"
        onClick={() => setGiftOpen(true)}
        className="fixed bottom-24 right-6 w-14 h-14 flare-gradient rounded-full flex items-center justify-center shadow-glow z-40 hover:scale-110 transition-transform active:scale-95"
      >
        <Gift className="w-6 h-6 text-white" />
      </button>
      <GiftModal open={giftOpen} onClose={() => setGiftOpen(false)} />
    </div>
  );
}

// ── Wallet Screen ─────────────────────────────────────────────────────────────
function WalletScreen() {
  const { user, setUser, gameHistory } = useApp();
  const [convertAmount, setConvertAmount] = useState("");
  const [rechargeOpen, setRechargeOpen] = useState(false);
  const [rechargeMethod, setRechargeMethod] = useState<"opay" | "paypal">(
    "opay",
  );
  const [selectedAmount, setSelectedAmount] = useState(0);
  const [processingPayment, setProcessingPayment] = useState(false);

  const diamondOutput = convertAmount ? Number(convertAmount) * 2 : 0;

  const handleConvert = () => {
    const amount = Number(convertAmount);
    if (!amount || amount > user.coins) {
      toast.error("Invalid amount");
      return;
    }
    setUser({
      ...user,
      coins: user.coins - amount,
      diamonds: user.diamonds + diamondOutput,
    });
    toast.success(`Converted 🪙${amount} → 💎${diamondOutput}!`);
    setConvertAmount("");
  };

  const rechargeAmounts = [
    { naira: 1000, coins: 500 },
    { naira: 5000, coins: 2500 },
    { naira: 10000, coins: 6000 },
    { naira: 30000, coins: 20000, host: true },
  ];

  const handleRecharge = async () => {
    const ra = rechargeAmounts.find((a) => a.naira === selectedAmount);
    if (!ra) return;
    setProcessingPayment(true);
    await new Promise((r) => setTimeout(r, 1500));
    setUser({
      ...user,
      coins: user.coins + ra.coins,
      totalRecharge: user.totalRecharge + ra.naira,
      role:
        ra.host || user.totalRecharge + ra.naira >= 30000 ? "host" : user.role,
    });
    toast.success(
      `Recharged 🪙${ra.coins.toLocaleString()} coins!${ra.host ? " 👑 You're now a Host!" : ""}`,
    );
    setProcessingPayment(false);
    setRechargeOpen(false);
  };

  return (
    <ScrollArea className="h-full" data-ocid="wallet.page">
      <div className="p-4 pb-24 space-y-4">
        {/* Balance card */}
        <div className="flare-gradient rounded-3xl p-5 shadow-glow text-white relative overflow-hidden">
          <div
            className="absolute top-0 right-0 w-32 h-32 rounded-full opacity-20"
            style={{
              background: "radial-gradient(circle, white, transparent)",
              transform: "translate(30%, -30%)",
            }}
          />
          <div className="shimmer absolute inset-0 rounded-3xl" />
          <div className="relative">
            <div className="flex items-center justify-between mb-4">
              <div>
                <p className="text-white/70 text-xs font-medium">My Wallet</p>
                <p className="text-white font-black text-xl">{user.name}</p>
              </div>
              <div className="flex items-center gap-1 bg-white/20 rounded-full px-3 py-1">
                <Crown className="w-4 h-4 text-yellow-300" />
                <span className="font-bold text-sm">Level {user.level}</span>
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="bg-white/15 rounded-2xl p-3">
                <p className="text-white/70 text-xs">Coins 🪙</p>
                <p className="text-white font-black text-2xl">
                  {user.coins.toLocaleString()}
                </p>
              </div>
              <div className="bg-white/15 rounded-2xl p-3">
                <p className="text-white/70 text-xs">Diamonds 💎</p>
                <p className="text-white font-black text-2xl">
                  {user.diamonds.toLocaleString()}
                </p>
              </div>
            </div>
            <div className="mt-3 flex items-center justify-between">
              <span className="text-white/70 text-xs">
                Total Recharge:{" "}
                <span className="text-white font-bold">
                  ₦{user.totalRecharge.toLocaleString()}
                </span>
              </span>
              {user.role !== "user" && (
                <span className="bg-yellow-400/30 text-yellow-200 text-xs font-bold px-2 py-1 rounded-full">
                  {user.role === "host" ? "👑 Host" : "🏢 Agency"}
                </span>
              )}
            </div>
          </div>
        </div>

        {/* Conversion */}
        <div className="bg-card rounded-3xl p-4 shadow-card border border-border">
          <h3 className="font-black text-base mb-3">🪙 → 💎 Convert</h3>
          <div className="flex gap-2 items-center">
            <div className="flex-1 relative">
              <Input
                data-ocid="wallet.convert_input"
                type="number"
                placeholder="Enter coins"
                value={convertAmount}
                onChange={(e) => setConvertAmount(e.target.value)}
                className="rounded-full pr-12"
              />
            </div>
            <ArrowRight className="w-5 h-5 text-muted-foreground flex-shrink-0" />
            <div className="flex-1 bg-cyan-50 border border-cyan-200 rounded-full px-4 py-2 text-cyan-700 font-bold text-sm">
              💎 {diamondOutput}
            </div>
          </div>
          <p className="text-muted-foreground text-xs mt-1.5 ml-2">
            Rate: 1 coin = 2 diamonds
          </p>
          <GradientButton
            data-ocid="wallet.convert_button"
            onClick={handleConvert}
            className="w-full mt-3"
          >
            Convert
          </GradientButton>
        </div>

        {/* Recharge */}
        <div className="bg-card rounded-3xl p-4 shadow-card border border-border">
          <h3 className="font-black text-base mb-3">⚡ Recharge Coins</h3>
          <div className="grid grid-cols-2 gap-3">
            <button
              type="button"
              data-ocid="wallet.opay_button"
              onClick={() => {
                setRechargeMethod("opay");
                setRechargeOpen(true);
              }}
              className="flex items-center justify-center gap-2 bg-emerald-50 border-2 border-emerald-400 rounded-2xl p-4 hover:bg-emerald-100 transition-colors active:scale-95"
            >
              <span className="text-2xl">🇳🇬</span>
              <div className="text-left">
                <p className="font-black text-emerald-700 text-sm">OPay</p>
                <p className="text-emerald-600 text-xs">Nigeria</p>
              </div>
            </button>
            <button
              type="button"
              data-ocid="wallet.paypal_button"
              onClick={() => {
                setRechargeMethod("paypal");
                setRechargeOpen(true);
              }}
              className="flex items-center justify-center gap-2 bg-blue-50 border-2 border-blue-400 rounded-2xl p-4 hover:bg-blue-100 transition-colors active:scale-95"
            >
              <span className="text-2xl">🌐</span>
              <div className="text-left">
                <p className="font-black text-blue-700 text-sm">PayPal</p>
                <p className="text-blue-600 text-xs">Global</p>
              </div>
            </button>
          </div>
        </div>

        {/* Game History */}
        <div className="bg-card rounded-3xl p-4 shadow-card border border-border">
          <h3 className="font-black text-base mb-3">🎮 Game History</h3>
          {gameHistory.length === 0 ? (
            <div
              data-ocid="wallet.game_history.empty_state"
              className="text-center py-6"
            >
              <Gamepad2 className="w-10 h-10 text-muted-foreground/40 mx-auto mb-2" />
              <p className="text-muted-foreground text-sm">
                No games played yet
              </p>
            </div>
          ) : (
            <div className="space-y-2">
              {gameHistory.slice(0, 5).map((g, i) => (
                <div
                  key={g.id}
                  data-ocid={`wallet.game_history.item.${i + 1}`}
                  className="flex items-center justify-between bg-secondary/50 rounded-2xl px-3 py-2.5"
                >
                  <div>
                    <p className="font-bold text-sm">{g.game}</p>
                    <p className="text-xs text-muted-foreground">
                      {g.timestamp}
                    </p>
                  </div>
                  <span
                    className={`text-sm font-black ${g.won ? "text-emerald-600" : "text-red-500"}`}
                  >
                    {g.won ? "+" : "-"}
                    {g.amount} {g.currency === "coins" ? "🪙" : "💎"}
                  </span>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Transactions */}
        <div className="bg-card rounded-3xl p-4 shadow-card border border-border">
          <h3 className="font-black text-base mb-3">📋 Transactions</h3>
          {[
            {
              label: "Starter Bonus",
              amount: "+5000 🪙",
              date: "Today",
              color: "text-emerald-600",
            },
            {
              label: "Gift Sent 🌹",
              amount: "-10 🪙",
              date: "Today",
              color: "text-red-500",
            },
            {
              label: "Diamond Received",
              amount: "+200 💎",
              date: "Yesterday",
              color: "text-cyan-600",
            },
          ].map((t, i) => (
            <div
              key={t.label}
              data-ocid={`wallet.transaction.item.${i + 1}`}
              className="flex items-center justify-between py-2.5 border-b border-border last:border-0"
            >
              <div>
                <p className="font-semibold text-sm">{t.label}</p>
                <p className="text-xs text-muted-foreground">{t.date}</p>
              </div>
              <span className={`font-black text-sm ${t.color}`}>
                {t.amount}
              </span>
            </div>
          ))}
        </div>
      </div>

      {/* Recharge Modal */}
      <Dialog
        open={rechargeOpen}
        onOpenChange={(v) => !v && setRechargeOpen(false)}
      >
        <DialogContent
          data-ocid="wallet.recharge.modal"
          className="max-w-sm rounded-3xl border-0 p-0 overflow-hidden"
        >
          <div className="flare-gradient p-4">
            <DialogTitle className="text-white font-black text-center text-lg">
              {rechargeMethod === "opay"
                ? "🇳🇬 OPay Recharge"
                : "🌐 PayPal Recharge"}
            </DialogTitle>
          </div>
          <div className="p-4 bg-white space-y-3">
            <p className="text-sm text-muted-foreground text-center">
              Select an amount to recharge
            </p>
            <div className="grid grid-cols-2 gap-3">
              {rechargeAmounts.map((a) => (
                <button
                  type="button"
                  key={a.naira}
                  data-ocid={`wallet.recharge.amount.${a.naira}`}
                  onClick={() => setSelectedAmount(a.naira)}
                  className={`rounded-2xl p-3 border-2 text-left transition-all ${
                    selectedAmount === a.naira
                      ? "border-flare-pink bg-pink-50"
                      : "border-border bg-secondary/50"
                  }`}
                >
                  <p className="font-black text-base">
                    ₦{a.naira.toLocaleString()}
                  </p>
                  <p className="text-xs text-muted-foreground">
                    🪙 {a.coins.toLocaleString()} coins
                  </p>
                  {a.host && (
                    <span className="text-xs font-bold text-orange-600">
                      👑 Become Host!
                    </span>
                  )}
                </button>
              ))}
            </div>
            <GradientButton
              data-ocid="wallet.recharge.confirm_button"
              onClick={handleRecharge}
              disabled={!selectedAmount || processingPayment}
              className="w-full"
            >
              {processingPayment
                ? "Processing..."
                : `Pay ${selectedAmount ? `₦${selectedAmount.toLocaleString()}` : ""}`}
            </GradientButton>
            <Button
              data-ocid="wallet.recharge.cancel_button"
              variant="ghost"
              className="w-full"
              onClick={() => setRechargeOpen(false)}
            >
              Cancel
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </ScrollArea>
  );
}

// ── Live Stream View ───────────────────────────────────────────────────────────
function LiveStreamView({
  streamId,
  onBack,
}: { streamId: number; onBack: () => void }) {
  const { user, setUser, setScreen } = useApp();
  const [giftOpen, setGiftOpen] = useState(false);
  const [floatingGift, setFloatingGift] = useState<string | null>(null);
  const [seconds, setSeconds] = useState(0);
  const [comments, setComments] = useState([
    { id: 1, user: "Mike", text: "You're amazing! 🔥", time: 0 },
    { id: 2, user: "Jade", text: "Sent you a crown 👑", time: 0 },
    { id: 3, user: "Emeka", text: "Keep going! 💕", time: 0 },
  ]);
  const [newComment, setNewComment] = useState("");
  const commentsRef = useRef<HTMLDivElement>(null);

  const stream = mockStreams.find((s) => s.id === streamId) || mockStreams[0];

  useEffect(() => {
    const t = setInterval(() => setSeconds((s) => s + 1), 1000);
    return () => clearInterval(t);
  }, []);

  useEffect(() => {
    const t = setInterval(() => {
      const emojis = ["🔥", "❤️", "😍", "💕", "✨"];
      const names = ["Tunde", "Kemi", "Bola", "Ngozi", "Dapo"];
      const msgs = [
        "So beautiful!",
        "Send more gifts!",
        "We love you!",
        "Best stream!",
        "🔥🔥🔥",
      ];
      setComments((c) => [
        ...c.slice(-20),
        {
          id: Date.now(),
          user: names[Math.floor(Math.random() * names.length)],
          text: `${msgs[Math.floor(Math.random() * msgs.length)]} ${emojis[Math.floor(Math.random() * emojis.length)]}`,
          time: Date.now(),
        },
      ]);
    }, 2500);
    return () => clearInterval(t);
    // biome-ignore lint/correctness/useExhaustiveDependencies: intentional interval
  }, []);

  // biome-ignore lint/correctness/useExhaustiveDependencies: intentional scroll
  useEffect(() => {
    if (commentsRef.current)
      commentsRef.current.scrollTop = commentsRef.current.scrollHeight;
  }, [comments]);

  const formatTime = (s: number) =>
    `${Math.floor(s / 60)
      .toString()
      .padStart(2, "0")}:${(s % 60).toString().padStart(2, "0")}`;

  const sendComment = () => {
    if (!newComment.trim()) return;
    setComments((c) => [
      ...c,
      { id: Date.now(), user: "You", text: newComment, time: seconds },
    ]);
    setNewComment("");
  };

  const sendStreamGift = (icon: string, cost: number) => {
    if (user.coins < cost) {
      toast.error("Not enough coins!");
      return;
    }
    setUser({ ...user, coins: user.coins - cost });
    setFloatingGift(icon);
    setTimeout(() => setFloatingGift(null), 2000);
    toast.success(`Gift sent! ${cost >= 1000 ? "🔥 Doubles at 12AM!" : ""}`);
  };

  return (
    <div className="h-full flex flex-col relative" data-ocid="live.view.page">
      {/* Video bg */}
      <div className="absolute inset-0">
        <img
          src={stream.image}
          alt={stream.name}
          className="w-full h-full object-cover"
        />
        <div
          className="absolute inset-0"
          style={{
            background:
              "linear-gradient(to bottom, rgba(0,0,0,0.6) 0%, transparent 30%, transparent 55%, rgba(0,0,0,0.85) 100%)",
          }}
        />
      </div>

      {/* Top bar */}
      <div className="relative z-10 flex items-center justify-between p-4">
        <button
          type="button"
          data-ocid="live.view.back_button"
          onClick={onBack}
          className="w-10 h-10 bg-black/40 rounded-full flex items-center justify-center"
        >
          <ChevronLeft className="w-5 h-5 text-white" />
        </button>
        <div className="flex items-center gap-2">
          <div className="flex items-center gap-2 bg-black/40 rounded-full px-3 py-1.5">
            <Avatar className="w-6 h-6">
              <AvatarImage src={stream.image} />
              <AvatarFallback>{stream.name[0]}</AvatarFallback>
            </Avatar>
            <button
              type="button"
              onClick={() => setScreen("profile")}
              className="text-white font-bold text-sm hover:underline"
            >
              {stream.name}
            </button>
          </div>
          <div className="flex items-center gap-1 bg-black/40 rounded-full px-2 py-1.5">
            <Eye className="w-3 h-3 text-white" />
            <span className="text-white text-xs">
              {stream.viewers.toLocaleString()}
            </span>
          </div>
        </div>
        <div className="bg-black/40 rounded-full px-3 py-1.5">
          <span className="text-white text-sm font-mono font-bold">
            {formatTime(seconds)}
          </span>
        </div>
      </div>

      {/* Doubling banner */}
      {seconds > 10 && (
        <div className="relative z-10 mx-4">
          <div className="flare-gradient rounded-2xl px-3 py-2 text-white text-xs font-bold text-center">
            🔥 Send 1000+ coins during this stream → Doubles at 12AM!
          </div>
        </div>
      )}

      {/* Comment feed */}
      <div
        ref={commentsRef}
        className="flex-1 relative z-10 overflow-y-auto px-4 py-2"
        style={{
          maskImage: "linear-gradient(to bottom, transparent, black 20%)",
        }}
      >
        <div className="space-y-1.5">
          {comments.map((c) => (
            <div key={c.id} className="flex items-start gap-2">
              <div className="w-6 h-6 flare-gradient-soft rounded-full flex items-center justify-center flex-shrink-0">
                <span className="text-white text-xs font-bold">
                  {c.user[0]}
                </span>
              </div>
              <div className="bg-black/50 rounded-full px-3 py-1 max-w-[80%]">
                <button
                  type="button"
                  onClick={() => setScreen("profile")}
                  className="text-white/60 text-xs font-bold hover:text-white inline"
                >
                  {c.user}:
                </button>{" "}
                <span className="text-white text-xs">{c.text}</span>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Bottom controls */}
      <div className="relative z-10 p-4 space-y-3">
        <div className="flex gap-2">
          <input
            value={newComment}
            onChange={(e) => setNewComment(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && sendComment()}
            placeholder="Say something... 💬"
            data-ocid="live.view.comment_input"
            className="flex-1 bg-black/50 border border-white/20 rounded-full px-4 py-2.5 text-white placeholder:text-white/50 text-sm focus:outline-none focus:border-white/50"
          />
          <button
            type="button"
            onClick={sendComment}
            data-ocid="live.view.send_comment_button"
            className="w-10 h-10 flare-gradient-soft rounded-full flex items-center justify-center"
          >
            <Send className="w-4 h-4 text-white" />
          </button>
          <button
            type="button"
            data-ocid="live.view.gift_button"
            onClick={() => setGiftOpen(true)}
            className="w-10 h-10 flare-gradient rounded-full flex items-center justify-center"
          >
            <Gift className="w-4 h-4 text-white" />
          </button>
        </div>
        {/* Quick gifts */}
        <div className="flex gap-2 overflow-x-auto pb-1">
          {giftItems.slice(0, 4).map((g) => (
            <button
              type="button"
              key={g.id}
              data-ocid={`live.view.quick_gift.${g.id}`}
              onClick={() => sendStreamGift(g.icon, g.cost)}
              className="flex-shrink-0 flex items-center gap-1 bg-black/50 border border-white/20 rounded-full px-3 py-1.5 text-white text-xs font-bold hover:bg-white/20 transition-colors"
            >
              {g.icon} <span>🪙{g.cost}</span>
            </button>
          ))}
        </div>
      </div>

      {/* Floating gift animation */}
      <AnimatePresence>
        {floatingGift && (
          <motion.div
            initial={{ opacity: 1, y: 0, scale: 1, x: "-50%" }}
            animate={{ opacity: 0, y: -200, scale: 3 }}
            exit={{ opacity: 0 }}
            className="fixed bottom-32 left-1/2 text-6xl pointer-events-none z-50"
          >
            {floatingGift}
          </motion.div>
        )}
      </AnimatePresence>

      <GiftModal open={giftOpen} onClose={() => setGiftOpen(false)} inStream />
    </div>
  );
}

// ── Live Screen ───────────────────────────────────────────────────────────────
function LiveScreen() {
  const { activeLiveStream, setActiveLiveStream, setScreen, user } = useApp();

  if (activeLiveStream !== null) {
    return (
      <LiveStreamView
        streamId={activeLiveStream}
        onBack={() => setActiveLiveStream(null)}
      />
    );
  }

  return (
    <ScrollArea className="h-full" data-ocid="live.page">
      <div className="p-4 pb-24">
        <div className="flex items-center justify-between mb-4">
          <h1 className="text-2xl font-black">🔴 Live Now</h1>
          <button
            type="button"
            data-ocid="live.go_live_button"
            onClick={() => {
              if (user.role === "host") {
                toast.success("🔴 Starting your live stream...");
              } else {
                toast.error(
                  "You need Host status to go live! Recharge ₦30,000+ to become a host.",
                );
              }
            }}
            className="flare-gradient text-white text-xs font-bold rounded-full px-3 py-1.5 flex items-center gap-1"
          >
            <Video className="w-3 h-3" /> Go Live
          </button>
        </div>

        <div className="grid grid-cols-2 gap-3">
          {mockStreams.map((stream, i) => (
            <motion.button
              key={stream.id}
              data-ocid={`live.stream.item.${i + 1}`}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: i * 0.08 }}
              onClick={() => setActiveLiveStream(stream.id)}
              className="relative rounded-3xl overflow-hidden aspect-[3/4] shadow-card text-left"
            >
              <img
                src={stream.image}
                alt={stream.name}
                className="w-full h-full object-cover"
              />
              <div
                className="absolute inset-0"
                style={{
                  background:
                    "linear-gradient(to top, rgba(0,0,0,0.8) 0%, transparent 50%)",
                }}
              />
              {/* LIVE badge */}
              <div className="absolute top-2 left-2 flex items-center gap-1">
                <span className="pulse-live bg-red-500 text-white text-xs font-black px-2 py-0.5 rounded-full">
                  LIVE
                </span>
              </div>
              {/* Viewer count */}
              <div className="absolute top-2 right-2 flex items-center gap-0.5 bg-black/50 rounded-full px-1.5 py-0.5">
                <Eye className="w-2.5 h-2.5 text-white" />
                <span className="text-white text-xs">
                  {stream.viewers.toLocaleString()}
                </span>
              </div>
              {/* Info */}
              <div className="absolute bottom-2 left-2 right-2">
                <button
                  type="button"
                  data-ocid={`live.stream.name.${i + 1}`}
                  onClick={(e) => {
                    e.stopPropagation();
                    setScreen("profile");
                  }}
                  className="text-white font-black text-sm leading-tight hover:underline"
                >
                  {stream.name}
                </button>
                <p className="text-white/70 text-xs">{stream.topic}</p>
                <p className="text-yellow-400 text-xs">
                  🎁 {stream.gifts} gifts
                </p>
              </div>
            </motion.button>
          ))}
        </div>
      </div>
    </ScrollArea>
  );
}

// ── Games Screen ──────────────────────────────────────────────────────────────
function GamesScreen() {
  const { user, setUser, addGameHistory, gameHistory } = useApp();
  const [activeGame, setActiveGame] = useState<(typeof gamesList)[0] | null>(
    null,
  );
  const [playing, setPlaying] = useState(false);
  const [result, setResult] = useState<{ won: boolean; amount: number } | null>(
    null,
  );
  const [tab, setTab] = useState<"games" | "history">("games");
  const [betAmounts, setBetAmounts] = useState<Record<string, number>>({});

  const getBet = (game: (typeof gamesList)[0]) =>
    betAmounts[game.id] ?? game.cost;

  const adjustBet = (game: (typeof gamesList)[0], delta: number) => {
    const current = getBet(game);
    const balance = game.currency === "coins" ? user.coins : user.diamonds;
    const next = Math.max(10, Math.min(balance, current + delta));
    setBetAmounts((prev) => ({ ...prev, [game.id]: next }));
  };

  const playGame = async (game: (typeof gamesList)[0]) => {
    const bet = getBet(game);
    const balance = game.currency === "coins" ? user.coins : user.diamonds;
    if (balance < bet) {
      toast.error(`Not enough ${game.currency}!`);
      return;
    }
    setPlaying(true);
    setResult(null);
    // Deduct bet
    const userAfterDeduct =
      game.currency === "coins"
        ? { ...user, coins: user.coins - bet }
        : { ...user, diamonds: user.diamonds - bet };
    setUser(userAfterDeduct);

    await new Promise((r) => setTimeout(r, 1200));

    const rewardBase =
      game.reward[Math.floor(Math.random() * game.reward.length)];
    const won = rewardBase > 0;
    const reward = won ? Math.round(bet * (rewardBase / game.cost)) : 0;

    if (won) {
      if (game.currency === "coins")
        setUser({ ...userAfterDeduct, coins: userAfterDeduct.coins + reward });
      else
        setUser({
          ...userAfterDeduct,
          diamonds: userAfterDeduct.diamonds + reward,
        });
    }

    const h: GameHistory = {
      id: Date.now(),
      game: game.name,
      result: won ? `Won ${reward} ${game.currency}` : "Lost",
      amount: won ? reward : bet,
      currency: game.currency,
      timestamp: new Date().toLocaleTimeString(),
      won,
    };
    addGameHistory(h);
    setResult({ won, amount: reward });
    setPlaying(false);
  };

  return (
    <div className="flex flex-col h-full" data-ocid="games.page">
      {/* Header */}
      <div className="px-4 pt-4 pb-2">
        <h1 className="text-2xl font-black">🎮 Mini-Games</h1>
        <div className="flex items-center gap-3 mt-2">
          <div className="flex items-center gap-1 bg-yellow-50 border border-yellow-200 rounded-full px-3 py-1">
            <span className="text-sm">🪙</span>
            <span className="text-sm font-bold text-yellow-600">
              {user.coins.toLocaleString()}
            </span>
          </div>
          <div className="flex items-center gap-1 bg-cyan-50 border border-cyan-200 rounded-full px-3 py-1">
            <span className="text-sm">💎</span>
            <span className="text-sm font-bold text-cyan-600">
              {user.diamonds.toLocaleString()}
            </span>
          </div>
        </div>
        {/* Tabs */}
        <div className="flex gap-2 mt-3">
          {(["games", "history"] as const).map((t) => (
            <button
              type="button"
              key={t}
              data-ocid={`games.${t}_tab`}
              onClick={() => setTab(t)}
              className={`rounded-full px-4 py-1.5 text-sm font-bold transition-all ${
                tab === t
                  ? "flare-gradient-soft text-white"
                  : "bg-secondary text-muted-foreground"
              }`}
            >
              {t === "games" ? "🎮 Games" : "📋 History"}
            </button>
          ))}
        </div>
      </div>

      <ScrollArea className="flex-1">
        <div className="p-4 pb-24">
          {tab === "games" ? (
            <div className="grid grid-cols-2 gap-3">
              {gamesList.map((game, i) => (
                <motion.div
                  key={game.id}
                  data-ocid={`games.card.item.${i + 1}`}
                  initial={{ opacity: 0, scale: 0.9 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ delay: i * 0.06 }}
                  className={`bg-gradient-to-br ${game.color} rounded-3xl p-4 shadow-card text-white relative overflow-hidden`}
                >
                  <div
                    className="absolute top-0 right-0 w-16 h-16 rounded-full bg-white/10"
                    style={{ transform: "translate(30%, -30%)" }}
                  />
                  <div className="text-4xl mb-2">{game.icon}</div>
                  <p className="font-black text-sm leading-tight">
                    {game.name}
                  </p>
                  {/* Bet stepper */}
                  <div className="flex items-center gap-1 mt-2">
                    <button
                      type="button"
                      data-ocid={`games.bet_minus.${i + 1}`}
                      onClick={(e) => {
                        e.stopPropagation();
                        adjustBet(game, -50);
                      }}
                      className="w-6 h-6 bg-white/30 hover:bg-white/50 rounded-full flex items-center justify-center text-white text-sm font-black transition-colors"
                    >
                      −
                    </button>
                    <span className="text-white text-xs font-bold min-w-[36px] text-center">
                      {game.currency === "coins" ? "🪙" : "💎"}
                      {getBet(game)}
                    </span>
                    <button
                      type="button"
                      data-ocid={`games.bet_plus.${i + 1}`}
                      onClick={(e) => {
                        e.stopPropagation();
                        adjustBet(game, 50);
                      }}
                      className="w-6 h-6 bg-white/30 hover:bg-white/50 rounded-full flex items-center justify-center text-white text-sm font-black transition-colors"
                    >
                      +
                    </button>
                  </div>
                  <button
                    type="button"
                    data-ocid={`games.play.${i + 1}`}
                    onClick={() => {
                      setActiveGame(game);
                      playGame(game);
                    }}
                    className="mt-2 bg-white/20 hover:bg-white/30 border border-white/30 rounded-full px-3 py-1 text-xs font-bold flex items-center gap-1 transition-colors"
                  >
                    <Play className="w-3 h-3" /> Play
                  </button>
                </motion.div>
              ))}
            </div>
          ) : (
            <div className="space-y-2">
              {gameHistory.length === 0 ? (
                <div
                  data-ocid="games.history.empty_state"
                  className="text-center py-12"
                >
                  <Gamepad2 className="w-12 h-12 text-muted-foreground/30 mx-auto mb-3" />
                  <p className="text-muted-foreground">No games played yet</p>
                  <button
                    type="button"
                    onClick={() => setTab("games")}
                    className="mt-3 text-primary font-bold text-sm"
                  >
                    Play now! 🎮
                  </button>
                </div>
              ) : (
                gameHistory.map((g, i) => (
                  <div
                    key={g.id}
                    data-ocid={`games.history.item.${i + 1}`}
                    className="bg-card rounded-2xl p-3 flex items-center justify-between border border-border"
                  >
                    <div>
                      <p className="font-bold text-sm">{g.game}</p>
                      <p className="text-xs text-muted-foreground">
                        {g.result} · {g.timestamp}
                      </p>
                    </div>
                    <span
                      className={`text-sm font-black ${g.won ? "text-emerald-600" : "text-red-500"}`}
                    >
                      {g.won ? `+${g.amount}` : `-${g.amount}`}{" "}
                      {g.currency === "coins" ? "🪙" : "💎"}
                    </span>
                  </div>
                ))
              )}
            </div>
          )}
        </div>
      </ScrollArea>

      {/* Game result modal */}
      <AnimatePresence>
        {(playing || result) && activeGame && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 bg-black/60 flex items-end justify-center"
            style={{
              maxWidth: 430,
              left: "50%",
              transform: "translateX(-50%)",
            }}
          >
            <motion.div
              initial={{ y: "100%" }}
              animate={{ y: 0 }}
              exit={{ y: "100%" }}
              className="w-full bg-card rounded-t-3xl p-6 text-center"
            >
              {playing ? (
                <>
                  <div className="text-6xl spin-result mb-4">
                    {activeGame.icon}
                  </div>
                  <p className="font-black text-lg">Rolling...</p>
                  <p className="text-muted-foreground text-sm mt-1">
                    Good luck! 🤞
                  </p>
                </>
              ) : result ? (
                <>
                  <motion.div
                    initial={{ scale: 0 }}
                    animate={{ scale: 1 }}
                    transition={{ type: "spring" }}
                    className="text-6xl mb-4"
                  >
                    {result.won ? "🎉" : "😢"}
                  </motion.div>
                  <p className="font-black text-2xl">
                    {result.won ? "You Won!" : "You Lost! 😢"}
                  </p>
                  {result.won && (
                    <p className="text-emerald-600 font-black text-xl mt-1">
                      +{result.amount}{" "}
                      {activeGame.currency === "coins" ? "🪙" : "💎"}
                    </p>
                  )}
                  <GradientButton
                    onClick={() => {
                      setResult(null);
                      setActiveGame(null);
                    }}
                    className="mt-4"
                  >
                    {result.won ? "Awesome! 🎊" : "Try Again"}
                  </GradientButton>
                </>
              ) : null}
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}

// ── Chat Screen ───────────────────────────────────────────────────────────────
function ChatScreen({ onBack }: { onBack: () => void }) {
  const [messages, setMessages] = useState(mockMessages);
  const [input, setInput] = useState("");
  const endRef = useRef<HTMLDivElement>(null);

  const sendMsg = () => {
    if (!input.trim()) return;
    setMessages((m) => [
      ...m,
      {
        id: Date.now(),
        from: "You",
        text: input,
        time: new Date().toLocaleTimeString([], {
          hour: "2-digit",
          minute: "2-digit",
        }),
        mine: true,
      },
    ]);
    setInput("");
    setTimeout(() => {
      const replies = [
        "That sounds great! 😊",
        "Can't wait! 💕",
        "You're so sweet 🥰",
        "Let's do it! 🎉",
      ];
      setMessages((m) => [
        ...m,
        {
          id: Date.now() + 1,
          from: "Sofia",
          text: replies[Math.floor(Math.random() * replies.length)],
          time: new Date().toLocaleTimeString([], {
            hour: "2-digit",
            minute: "2-digit",
          }),
          mine: false,
        },
      ]);
    }, 1200);
  };

  // biome-ignore lint/correctness/useExhaustiveDependencies: intentional scroll
  useEffect(() => {
    endRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  return (
    <div className="flex flex-col h-full bg-background" data-ocid="chat.page">
      <div className="flex items-center gap-3 p-4 bg-card border-b border-border">
        <button
          type="button"
          data-ocid="chat.back_button"
          onClick={onBack}
          className="w-8 h-8 flex items-center justify-center"
        >
          <ChevronLeft className="w-5 h-5" />
        </button>
        <Avatar className="w-10 h-10">
          <AvatarImage src="/assets/generated/profile-sofia.dim_400x500.jpg" />
          <AvatarFallback>S</AvatarFallback>
        </Avatar>
        <div>
          <p className="font-black">Sofia</p>
          <p className="text-xs text-emerald-500 font-medium">● Online</p>
        </div>
        <div className="ml-auto flex items-center gap-1 text-xs text-cyan-500 font-bold">
          <span>💎</span>
          <span>450</span>
        </div>
      </div>

      <ScrollArea className="flex-1 p-4">
        <div className="space-y-3">
          {messages.map((m, i) => (
            <div
              key={m.id}
              data-ocid={`chat.message.item.${i + 1}`}
              className={`flex ${m.mine ? "justify-end" : "justify-start"}`}
            >
              <div
                className={`max-w-[75%] rounded-2xl px-4 py-2.5 ${m.mine ? "flare-gradient-soft text-white" : "bg-card border border-border"}`}
              >
                <p className="text-sm">{m.text}</p>
                <p
                  className={`text-xs mt-0.5 ${m.mine ? "text-white/60" : "text-muted-foreground"}`}
                >
                  {m.time}
                </p>
              </div>
            </div>
          ))}
          <div ref={endRef} />
        </div>
      </ScrollArea>

      <div className="p-3 border-t border-border flex gap-2">
        <Input
          data-ocid="chat.message_input"
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && sendMsg()}
          placeholder="Type a message..."
          className="rounded-full flex-1"
        />
        <button
          type="button"
          data-ocid="chat.send_button"
          onClick={sendMsg}
          className="w-10 h-10 flare-gradient-soft rounded-full flex items-center justify-center flex-shrink-0"
        >
          <Send className="w-4 h-4 text-white" />
        </button>
      </div>
    </div>
  );
}

// ── Agency Screen ─────────────────────────────────────────────────────────────
function AgencyScreen({ onBack }: { onBack: () => void }) {
  const { user } = useApp();
  const [groupType, setGroupType] = useState<"agency" | "family">("agency");
  const [members, setMembers] = useState(mockAgencyMembers);

  const removeMember = (id: number) => {
    setMembers((m) => m.filter((mem) => mem.id !== id));
    toast.success("Member removed");
  };

  return (
    <div className="flex flex-col h-full bg-background" data-ocid="agency.page">
      <div className="flex items-center gap-3 p-4 bg-card border-b border-border">
        <button type="button" data-ocid="agency.back_button" onClick={onBack}>
          <ChevronLeft className="w-5 h-5" />
        </button>
        <h1 className="font-black text-lg">Agency & Family</h1>
      </div>

      <ScrollArea className="flex-1">
        <div className="p-4 pb-24 space-y-4">
          {/* Toggle */}
          <div className="flex bg-secondary rounded-full p-1">
            {(["agency", "family"] as const).map((t) => (
              <button
                type="button"
                key={t}
                data-ocid={`agency.${t}_tab`}
                onClick={() => setGroupType(t)}
                className={`flex-1 rounded-full py-2 text-sm font-bold transition-all ${
                  groupType === t
                    ? "flare-gradient-soft text-white shadow"
                    : "text-muted-foreground"
                }`}
              >
                {t === "agency" ? "🏢 Agency" : "👨‍👩‍👧 Family"}
              </button>
            ))}
          </div>

          {/* Group Info */}
          <div className="flare-gradient rounded-3xl p-4 text-white">
            <div className="flex items-center gap-3">
              <div className="w-14 h-14 bg-white/20 rounded-2xl flex items-center justify-center text-3xl">
                {groupType === "agency" ? "🏢" : "💞"}
              </div>
              <div>
                <p className="font-black text-lg">
                  {groupType === "agency" ? "FlareUp Stars" : "Love Family"}
                </p>
                <p className="text-white/70 text-sm">
                  Manager: {user.name || "You"}
                </p>
                <p className="text-white/70 text-xs">
                  {members.length} members
                </p>
              </div>
            </div>
          </div>

          {/* Members */}
          <div className="bg-card rounded-3xl p-4 border border-border">
            <div className="flex items-center justify-between mb-3">
              <h3 className="font-black">Members</h3>
              <button
                type="button"
                data-ocid="agency.invite_button"
                onClick={() => toast.success("Invite link copied! 🔗")}
                className="flex items-center gap-1 flare-gradient-soft text-white text-xs font-bold rounded-full px-3 py-1.5"
              >
                <Plus className="w-3 h-3" /> Invite
              </button>
            </div>
            <div className="space-y-3">
              {members.map((m, i) => (
                <div
                  key={m.id}
                  data-ocid={`agency.member.item.${i + 1}`}
                  className="flex items-center justify-between"
                >
                  <div className="flex items-center gap-3">
                    <Avatar className="w-10 h-10">
                      <AvatarImage src={m.avatar} />
                      <AvatarFallback>{m.name[0]}</AvatarFallback>
                    </Avatar>
                    <div>
                      <p className="font-bold text-sm">{m.name}</p>
                      <span
                        className={`text-xs font-bold rounded-full px-2 py-0.5 ${
                          m.role === "host"
                            ? "bg-yellow-100 text-yellow-700"
                            : "bg-pink-100 text-pink-700"
                        }`}
                      >
                        {m.role}
                      </span>
                    </div>
                  </div>
                  <button
                    type="button"
                    data-ocid={`agency.remove_button.${i + 1}`}
                    onClick={() => removeMember(m.id)}
                    className="text-xs text-red-500 border border-red-200 rounded-full px-2.5 py-1 hover:bg-red-50 transition-colors"
                  >
                    Remove
                  </button>
                </div>
              ))}
            </div>
          </div>

          <button
            type="button"
            data-ocid="agency.create_button"
            onClick={() => toast.success(`New ${groupType} group created! 🎉`)}
            className="w-full border-2 border-dashed border-primary/40 rounded-3xl p-4 text-primary font-bold flex items-center justify-center gap-2 hover:bg-primary/5 transition-colors"
          >
            <Plus className="w-5 h-5" /> Create New{" "}
            {groupType === "agency" ? "Agency" : "Family"}
          </button>
        </div>
      </ScrollArea>
    </div>
  );
}

// ── Profile Screen ────────────────────────────────────────────────────────────
function ContactUsScreen({ onBack }: { onBack: () => void }) {
  return (
    <div className="flex flex-col h-full" data-ocid="contact.page">
      <div className="flex items-center gap-3 px-4 pt-4 pb-3 border-b border-border">
        <button
          type="button"
          onClick={onBack}
          className="w-9 h-9 rounded-full bg-secondary flex items-center justify-center"
        >
          <ChevronLeft className="w-5 h-5" />
        </button>
        <h1 className="text-xl font-black">Contact Us</h1>
      </div>
      <ScrollArea className="flex-1">
        <div className="p-4 space-y-4 pb-24">
          <div className="flare-gradient rounded-3xl p-5 text-center text-white">
            <div className="text-4xl mb-2">💬</div>
            <h2 className="font-black text-xl">We're here to help!</h2>
            <p className="text-white/80 text-sm mt-1">
              Our team responds within 24 hours
            </p>
          </div>
          {[
            {
              icon: "📧",
              title: "Email Support",
              desc: "support@flareup.app",
              sub: "Response within 24 hours",
            },
            {
              icon: "💬",
              title: "Live Chat",
              desc: "Chat with an agent now",
              sub: "Available 9AM - 9PM WAT",
            },
            {
              icon: "📱",
              title: "WhatsApp",
              desc: "+234 800 FLAREUP",
              sub: "Quick replies on WhatsApp",
            },
            {
              icon: "❓",
              title: "FAQ & Help Center",
              desc: "Browse common questions",
              sub: "Instant answers",
            },
            {
              icon: "🐦",
              title: "Twitter / X",
              desc: "@FlareUpApp",
              sub: "DM us for fast support",
            },
          ].map((item) => (
            <div
              key={item.title}
              className="bg-card border border-border rounded-2xl p-4 flex items-center gap-3 shadow-xs"
            >
              <div className="w-12 h-12 bg-primary/10 rounded-2xl flex items-center justify-center text-2xl flex-shrink-0">
                {item.icon}
              </div>
              <div className="flex-1">
                <p className="font-bold text-sm">{item.title}</p>
                <p className="text-primary text-sm font-medium">{item.desc}</p>
                <p className="text-xs text-muted-foreground">{item.sub}</p>
              </div>
              <ArrowRight className="w-4 h-4 text-muted-foreground" />
            </div>
          ))}
        </div>
      </ScrollArea>
    </div>
  );
}

function ProfileScreen() {
  const { user, setUser, setScreen, setIsLoggedIn } = useApp();
  const [chatOpen, setChatOpen] = useState(false);
  const [agencyOpen, setAgencyOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [subOpen, setSubOpen] = useState(false);
  const [settingsOpen, setSettingsOpen] = useState(false);
  const [editForm, setEditForm] = useState({
    name: user.name,
    bio: user.bio,
    country: user.country,
  });
  const [processingSubscription, setProcessingSubscription] = useState(false);
  const [contactOpen, setContactOpen] = useState(false);

  if (chatOpen) return <ChatScreen onBack={() => setChatOpen(false)} />;
  if (agencyOpen) return <AgencyScreen onBack={() => setAgencyOpen(false)} />;
  if (contactOpen)
    return <ContactUsScreen onBack={() => setContactOpen(false)} />;

  const handleSaveProfile = () => {
    setUser({ ...user, ...editForm });
    setEditOpen(false);
    toast.success("Profile updated! ✨");
  };

  const handleSubscribe = async () => {
    setProcessingSubscription(true);
    await new Promise((r) => setTimeout(r, 1500));
    setUser({ ...user, isPremium: true });
    toast.success("🌟 Welcome to Premium!");
    setProcessingSubscription(false);
    setSubOpen(false);
  };

  return (
    <ScrollArea className="h-full" data-ocid="profile.page">
      <div className="pb-24">
        {/* Cover */}
        <div className="flare-gradient h-36 relative">
          <div className="absolute -bottom-12 left-1/2 -translate-x-1/2">
            <div className="w-24 h-24 rounded-full border-4 border-white overflow-hidden shadow-glow">
              <img
                src="/assets/generated/profile-sofia.dim_400x500.jpg"
                alt="Profile"
                className="w-full h-full object-cover"
                style={{ filter: "hue-rotate(180deg) saturate(1.2)" }}
              />
            </div>
          </div>
          <div className="absolute top-4 right-4 flex gap-2">
            <button
              type="button"
              data-ocid="profile.settings_button"
              onClick={() => setSettingsOpen(true)}
              className="w-8 h-8 bg-white/20 rounded-full flex items-center justify-center"
            >
              <Settings className="w-4 h-4 text-white" />
            </button>
          </div>
        </div>

        <div className="pt-16 px-4">
          {/* Name & role */}
          <div className="text-center">
            <h2 className="text-2xl font-black">{user.name || "Your Name"}</h2>
            <div className="flex items-center justify-center gap-2 mt-1">
              <span
                className={`text-xs font-bold rounded-full px-2 py-1 ${
                  user.role === "host"
                    ? "bg-yellow-100 text-yellow-700"
                    : user.role === "agency"
                      ? "bg-purple-100 text-purple-700"
                      : "bg-pink-100 text-pink-700"
                }`}
              >
                {user.role === "host"
                  ? "👑 Host"
                  : user.role === "agency"
                    ? "🏢 Agency"
                    : "💕 User"}
              </span>
              <span className="text-xs font-bold bg-primary/10 text-primary rounded-full px-2 py-1">
                ⚡ Level {user.level}
              </span>
              {user.isPremium && (
                <span className="text-xs font-bold bg-yellow-100 text-yellow-700 rounded-full px-2 py-1">
                  ⭐ Premium
                </span>
              )}
            </div>
            <p className="text-muted-foreground text-sm mt-1">
              {user.bio || "Add a bio..."}
            </p>
            <p className="text-xs text-muted-foreground mt-0.5">
              📍 {user.country}
            </p>
          </div>

          {/* Stats */}
          <div className="grid grid-cols-3 gap-3 mt-4">
            {[
              { label: "Coins Sent", value: "1,240 🪙" },
              { label: "Diamonds", value: `${user.diamonds} 💎` },
              { label: "Gifts", value: "38 🎁" },
            ].map((s) => (
              <div
                key={s.label}
                className="bg-card rounded-2xl p-3 text-center border border-border shadow-xs"
              >
                <p className="font-black text-sm">{s.value}</p>
                <p className="text-xs text-muted-foreground mt-0.5">
                  {s.label}
                </p>
              </div>
            ))}
          </div>

          {/* Action buttons */}
          <div className="flex gap-2 mt-4">
            <button
              type="button"
              data-ocid="profile.edit_button"
              onClick={() => setEditOpen(true)}
              className="flex-1 flex items-center justify-center gap-2 bg-card border border-border rounded-full py-2.5 font-bold text-sm hover:bg-secondary transition-colors"
            >
              <Settings className="w-4 h-4" /> Edit Profile
            </button>
            <button
              type="button"
              data-ocid="profile.chat_button"
              onClick={() => setChatOpen(true)}
              className="flex-1 flex items-center justify-center gap-2 flare-gradient-soft text-white rounded-full py-2.5 font-bold text-sm"
            >
              <MessageCircle className="w-4 h-4" /> Messages
            </button>
          </div>

          {/* Premium card */}
          {!user.isPremium && (
            <div className="flare-gradient rounded-3xl p-4 mt-4 relative overflow-hidden">
              <div
                className="absolute top-0 right-0 w-24 h-24 rounded-full bg-white/10"
                style={{ transform: "translate(30%, -30%)" }}
              />
              <div className="flex items-start justify-between relative">
                <div>
                  <div className="flex items-center gap-2 mb-2">
                    <Crown className="w-5 h-5 text-yellow-300" />
                    <span className="text-white font-black">Go Premium</span>
                    <span className="bg-white/20 text-white text-xs font-bold rounded-full px-2 py-0.5">
                      $6/mo
                    </span>
                  </div>
                  <ul className="space-y-1">
                    {[
                      "Unlimited likes",
                      "See who liked you",
                      "Priority in feeds",
                      "Exclusive badges",
                    ].map((p) => (
                      <li
                        key={p}
                        className="flex items-center gap-1.5 text-white/90 text-xs"
                      >
                        <CheckCircle className="w-3 h-3 text-yellow-300" /> {p}
                      </li>
                    ))}
                  </ul>
                </div>
                <button
                  type="button"
                  data-ocid="profile.subscribe_button"
                  onClick={() => setSubOpen(true)}
                  className="bg-white text-flare-pink font-black text-sm rounded-full px-4 py-2 ml-3 shadow flex-shrink-0"
                >
                  Subscribe
                </button>
              </div>
            </div>
          )}

          {/* Agency/Family */}
          <button
            type="button"
            data-ocid="profile.agency_button"
            onClick={() => setAgencyOpen(true)}
            className="w-full mt-4 flex items-center justify-between bg-card border border-border rounded-2xl p-4 hover:bg-secondary transition-colors"
          >
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-purple-100 rounded-2xl flex items-center justify-center text-xl">
                🏢
              </div>
              <div className="text-left">
                <p className="font-bold text-sm">My Agency / Family</p>
                <p className="text-xs text-muted-foreground">
                  FlareUp Stars · 4 members
                </p>
              </div>
            </div>
            <ArrowRight className="w-4 h-4 text-muted-foreground" />
          </button>

          {/* Contact Us */}
          <button
            type="button"
            data-ocid="profile.contact_button"
            onClick={() => setContactOpen(true)}
            className="w-full mt-3 flex items-center justify-between bg-card border border-border rounded-2xl p-4 hover:bg-secondary transition-colors"
          >
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-blue-100 rounded-2xl flex items-center justify-center text-xl">
                💬
              </div>
              <div className="text-left">
                <p className="font-bold text-sm">Contact Us</p>
                <p className="text-xs text-muted-foreground">
                  Customer support & help
                </p>
              </div>
            </div>
            <ArrowRight className="w-4 h-4 text-muted-foreground" />
          </button>

          {/* Logout */}
          <button
            type="button"
            data-ocid="profile.logout_button"
            onClick={() => {
              setIsLoggedIn(false);
              setScreen("auth");
              toast.success("Logged out. See you soon! 👋");
            }}
            className="w-full mt-4 border border-red-200 text-red-500 rounded-full py-3 font-bold text-sm hover:bg-red-50 transition-colors"
          >
            Logout
          </button>
        </div>
      </div>

      {/* Edit Profile Modal */}
      <Dialog open={editOpen} onOpenChange={(v) => !v && setEditOpen(false)}>
        <DialogContent
          data-ocid="profile.edit.modal"
          className="max-w-sm rounded-3xl"
        >
          <DialogHeader>
            <DialogTitle className="font-black">✏️ Edit Profile</DialogTitle>
          </DialogHeader>
          <div className="space-y-3">
            <div>
              <Label className="text-xs font-bold mb-1 block">Name</Label>
              <Input
                data-ocid="profile.edit.name_input"
                value={editForm.name}
                onChange={(e) =>
                  setEditForm((p) => ({ ...p, name: e.target.value }))
                }
                className="rounded-full"
              />
            </div>
            <div>
              <Label className="text-xs font-bold mb-1 block">Bio</Label>
              <Input
                data-ocid="profile.edit.bio_input"
                value={editForm.bio}
                onChange={(e) =>
                  setEditForm((p) => ({ ...p, bio: e.target.value }))
                }
                placeholder="Tell us about yourself..."
                className="rounded-full"
              />
            </div>
            <div>
              <Label className="text-xs font-bold mb-1 block">Country</Label>
              <Input
                data-ocid="profile.edit.country_input"
                value={editForm.country}
                onChange={(e) =>
                  setEditForm((p) => ({ ...p, country: e.target.value }))
                }
                className="rounded-full"
              />
            </div>
            <div className="flex gap-2">
              <button
                type="button"
                data-ocid="profile.edit.cancel_button"
                onClick={() => setEditOpen(false)}
                className="flex-1 border border-border rounded-full py-2.5 font-bold text-sm"
              >
                Cancel
              </button>
              <GradientButton
                data-ocid="profile.edit.save_button"
                onClick={handleSaveProfile}
                className="flex-1"
              >
                Save ✨
              </GradientButton>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Subscription Modal */}
      <Dialog open={subOpen} onOpenChange={(v) => !v && setSubOpen(false)}>
        <DialogContent
          data-ocid="profile.subscription.modal"
          className="max-w-sm rounded-3xl p-0 overflow-hidden border-0"
        >
          <div className="flare-gradient p-5 text-center">
            <Crown className="w-12 h-12 text-yellow-300 mx-auto mb-2" />
            <h2 className="text-white font-black text-2xl">FlareUp Premium</h2>
            <p className="text-white/80 text-sm mt-1">
              Unlock the full FlareUp experience
            </p>
            <p className="text-white font-black text-3xl mt-3">
              $6<span className="text-base font-normal">/month</span>
            </p>
          </div>
          <div className="bg-white p-5">
            <ul className="space-y-3 mb-5">
              {[
                { icon: "❤️", text: "Unlimited daily likes" },
                { icon: "👁️", text: "See who liked your profile" },
                { icon: "🔝", text: "Priority placement in feeds" },
                { icon: "✨", text: "Exclusive premium badges" },
                { icon: "💬", text: "Unlimited messaging" },
                { icon: "🎁", text: "5% bonus coins on recharge" },
              ].map((p) => (
                <li key={p.text} className="flex items-center gap-3">
                  <span className="text-xl">{p.icon}</span>
                  <span className="text-sm font-medium">{p.text}</span>
                  <CheckCircle className="w-4 h-4 text-emerald-500 ml-auto" />
                </li>
              ))}
            </ul>
            <GradientButton
              data-ocid="profile.subscription.confirm_button"
              onClick={handleSubscribe}
              disabled={processingSubscription}
              className="w-full"
            >
              {processingSubscription ? "Processing..." : "Subscribe Now 🔥"}
            </GradientButton>
            <Button
              data-ocid="profile.subscription.cancel_button"
              variant="ghost"
              className="w-full mt-2"
              onClick={() => setSubOpen(false)}
            >
              Maybe Later
            </Button>
          </div>
        </DialogContent>
      </Dialog>

      {/* Settings Sheet */}
      <Sheet open={settingsOpen} onOpenChange={setSettingsOpen}>
        <SheetContent
          side="bottom"
          className="rounded-t-3xl max-h-[85vh] overflow-y-auto"
          data-ocid="profile.settings.sheet"
        >
          <SheetHeader className="mb-4">
            <SheetTitle className="font-black text-lg">⚙️ Settings</SheetTitle>
          </SheetHeader>
          <div className="space-y-2 pb-8">
            {[
              {
                icon: "✏️",
                label: "Edit Profile",
                action: () => {
                  setSettingsOpen(false);
                  setTimeout(() => setEditOpen(true), 200);
                },
              },
              {
                icon: "🔒",
                label: "Privacy Settings",
                action: () => toast.success("Privacy settings saved ✅"),
              },
              {
                icon: "🔔",
                label: "Notification Preferences",
                action: () =>
                  toast.success("Notification preferences updated 🔔"),
              },
              {
                icon: "🔑",
                label: "Change Password",
                action: () =>
                  toast.info("A password reset link has been sent 📧"),
              },
              {
                icon: "🌍",
                label: "Language & Region",
                action: () => toast.success("Language set to English 🌍"),
              },
              {
                icon: "👁️",
                label: "Visibility",
                action: () => toast.success("Profile visibility updated 👁️"),
              },
              {
                icon: "💬",
                label: "Help & Support",
                action: () => {
                  setSettingsOpen(false);
                  setTimeout(() => setContactOpen(true), 200);
                },
              },
              {
                icon: "⭐",
                label: "Rate FlareUp",
                action: () => toast.success("Thanks for the love! ⭐⭐⭐⭐⭐"),
              },
              {
                icon: "🚪",
                label: "Log Out",
                action: () => {
                  setSettingsOpen(false);
                  setTimeout(() => {
                    setIsLoggedIn(false);
                    setScreen("auth");
                    toast.success("Logged out. See you soon! 👋");
                  }, 200);
                },
                danger: true,
              },
            ].map((item) => (
              <button
                key={item.label}
                type="button"
                onClick={item.action}
                className={`w-full flex items-center gap-3 p-4 rounded-2xl hover:bg-secondary transition-colors text-left ${(item as { danger?: boolean }).danger ? "hover:bg-red-50" : ""}`}
              >
                <span className="text-xl w-8 text-center">{item.icon}</span>
                <span
                  className={`font-semibold text-sm flex-1 ${(item as { danger?: boolean }).danger ? "text-red-500" : ""}`}
                >
                  {item.label}
                </span>
                <ArrowRight className="w-4 h-4 text-muted-foreground" />
              </button>
            ))}
          </div>
        </SheetContent>
      </Sheet>
    </ScrollArea>
  );
}

// ── Messages Screen ───────────────────────────────────────────────────────────
const systemMessages = [
  {
    id: 1,
    text: "Welcome to FlareUp! 🔥 Start exploring matches.",
    time: "Just now",
    unread: true,
  },
  {
    id: 2,
    text: "Your profile was liked 5 times today! 💕",
    time: "2h ago",
    unread: true,
  },
  {
    id: 3,
    text: "New match available nearby. Check it out!",
    time: "Yesterday",
    unread: false,
  },
  {
    id: 4,
    text: "Reminder: Top up coins to unlock premium features.",
    time: "2d ago",
    unread: false,
  },
];

const mockConversations = [
  {
    id: 1,
    name: "Sofia",
    avatar: "/assets/generated/profile-sofia.dim_400x500.jpg",
    lastMsg: "Can't wait! 💕",
    time: "5m",
    online: true,
    unread: 2,
  },
  {
    id: 2,
    name: "Mei Lin",
    avatar: "/assets/generated/home-match2.dim_400x500.jpg",
    lastMsg: "That sounds great! 😊",
    time: "1h",
    online: true,
    unread: 0,
  },
  {
    id: 3,
    name: "Aisha",
    avatar: "/assets/generated/home-match3.dim_400x500.jpg",
    lastMsg: "Let's chat soon 🌸",
    time: "3h",
    online: false,
    unread: 1,
  },
  {
    id: 4,
    name: "Priya",
    avatar: "/assets/generated/home-match4.dim_400x500.jpg",
    lastMsg: "You're so sweet 🥰",
    time: "Yesterday",
    online: false,
    unread: 0,
  },
];

function MessagesScreen() {
  const { setScreen } = useApp();
  const [systemOpen, setSystemOpen] = useState(false);

  return (
    <div className="flex flex-col h-full" data-ocid="messages.page">
      {/* Header */}
      <div className="px-4 pt-5 pb-3 bg-background border-b border-border">
        <h1 className="text-2xl font-black">💬 Messages</h1>
        <p className="text-xs text-muted-foreground mt-0.5">
          Your conversations & notifications
        </p>
      </div>

      <ScrollArea className="flex-1">
        <div className="pb-24">
          {/* System Messages pinned thread */}
          <div className="px-4 pt-4 pb-2">
            <p className="text-xs font-bold text-muted-foreground uppercase tracking-wider mb-2">
              System
            </p>
            <button
              type="button"
              data-ocid="messages.system.button"
              onClick={() => setSystemOpen(!systemOpen)}
              className="w-full flex items-center gap-3 bg-card border border-border rounded-2xl p-3 hover:bg-secondary transition-colors"
            >
              <div className="w-12 h-12 flare-gradient rounded-full flex items-center justify-center flex-shrink-0">
                <span className="text-2xl">🔔</span>
              </div>
              <div className="flex-1 text-left">
                <div className="flex items-center justify-between">
                  <p className="font-black text-sm">FlareUp Notifications</p>
                  <span className="text-xs text-muted-foreground">Now</span>
                </div>
                <p className="text-xs text-muted-foreground truncate">
                  Welcome to FlareUp! 🔥 Start exploring...
                </p>
              </div>
              <div className="w-5 h-5 flare-gradient rounded-full flex items-center justify-center flex-shrink-0">
                <span className="text-white text-[10px] font-bold">2</span>
              </div>
            </button>

            {/* Expanded system messages */}
            {systemOpen && (
              <motion.div
                initial={{ opacity: 0, height: 0 }}
                animate={{ opacity: 1, height: "auto" }}
                className="mt-2 space-y-2 pl-2"
              >
                {systemMessages.map((msg) => (
                  <div
                    key={msg.id}
                    data-ocid={`messages.system.item.${msg.id}`}
                    className={`flex items-start gap-3 rounded-xl p-2.5 ${msg.unread ? "bg-pink-50 border border-pink-100" : "bg-secondary/40"}`}
                  >
                    <span className="text-lg mt-0.5">
                      {msg.unread ? "🔴" : "⚪"}
                    </span>
                    <div className="flex-1">
                      <p className="text-sm text-foreground">{msg.text}</p>
                      <p className="text-xs text-muted-foreground mt-0.5">
                        {msg.time}
                      </p>
                    </div>
                  </div>
                ))}
              </motion.div>
            )}
          </div>

          {/* User conversations */}
          <div className="px-4 pt-3">
            <p className="text-xs font-bold text-muted-foreground uppercase tracking-wider mb-2">
              Conversations
            </p>
            <div className="space-y-1">
              {mockConversations.map((conv, i) => (
                <button
                  type="button"
                  key={conv.id}
                  data-ocid={`messages.conversation.item.${i + 1}`}
                  onClick={() => setScreen("chat")}
                  className="w-full flex items-center gap-3 rounded-2xl p-3 hover:bg-secondary transition-colors"
                >
                  <div className="relative flex-shrink-0">
                    <Avatar className="w-12 h-12">
                      <AvatarImage src={conv.avatar} />
                      <AvatarFallback>{conv.name[0]}</AvatarFallback>
                    </Avatar>
                    {conv.online && (
                      <span className="absolute bottom-0 right-0 w-3 h-3 bg-emerald-500 rounded-full border-2 border-background" />
                    )}
                  </div>
                  <div className="flex-1 text-left min-w-0">
                    <div className="flex items-center justify-between">
                      <p className="font-black text-sm">{conv.name}</p>
                      <span className="text-xs text-muted-foreground">
                        {conv.time}
                      </span>
                    </div>
                    <p className="text-xs text-muted-foreground truncate">
                      {conv.lastMsg}
                    </p>
                  </div>
                  {conv.unread > 0 && (
                    <div className="w-5 h-5 flare-gradient rounded-full flex items-center justify-center flex-shrink-0">
                      <span className="text-white text-[10px] font-bold">
                        {conv.unread}
                      </span>
                    </div>
                  )}
                </button>
              ))}
            </div>
          </div>
        </div>
      </ScrollArea>
    </div>
  );
}

// ── Bottom Navigation ─────────────────────────────────────────────────────────
const navItems = [
  { id: "home" as Screen, icon: Flame, label: "Home" },
  { id: "wallet" as Screen, icon: Wallet, label: "Wallet" },
  { id: "messages" as Screen, icon: MessageCircle, label: "Messages" },
  { id: "live" as Screen, icon: Video, label: "Live" },
  { id: "games" as Screen, icon: Gamepad2, label: "Games" },
  { id: "profile" as Screen, icon: User, label: "Profile" },
];

function BottomNav() {
  const { screen, setScreen, activeLiveStream, setActiveLiveStream } = useApp();

  const handleNav = (id: Screen) => {
    if (id !== "live" && activeLiveStream !== null) setActiveLiveStream(null);
    setScreen(id);
  };

  return (
    <nav className="absolute bottom-0 left-0 right-0 bg-white border-t border-border flex z-30">
      {navItems.map((item) => {
        const Icon = item.icon;
        const active = screen === item.id;
        return (
          <button
            type="button"
            key={item.id}
            data-ocid={`nav.${item.id}_link`}
            onClick={() => handleNav(item.id)}
            className={`flex-1 flex flex-col items-center py-3 gap-0.5 transition-all ${
              active ? "text-flare-pink" : "text-muted-foreground"
            }`}
          >
            <div
              className={`relative p-1.5 rounded-2xl transition-all ${
                active ? "flare-gradient-soft" : ""
              }`}
            >
              <Icon className={`w-5 h-5 ${active ? "text-white" : ""}`} />
              {item.id === "live" && (
                <span className="absolute -top-0.5 -right-0.5 w-2 h-2 bg-red-500 rounded-full pulse-live" />
              )}
            </div>
            <span
              className={`text-[10px] font-bold ${active ? "text-flare-pink" : "text-muted-foreground"}`}
            >
              {item.label}
            </span>
          </button>
        );
      })}
    </nav>
  );
}

// ── Main App ──────────────────────────────────────────────────────────────────
export default function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [screen, setScreen] = useState<Screen>("auth");
  const [activeLiveStream, setActiveLiveStream] = useState<number | null>(null);
  const [user, setUser] = useState<UserState>({
    name: "",
    email: "",
    gender: "male",
    country: "Nigeria",
    coins: 0,
    diamonds: 200,
    level: 3,
    totalRecharge: 15000,
    role: "user",
    isPremium: false,
    bio: "Ready to find love 🔥",
  });
  const [gameHistory, setGameHistory] = useState<GameHistory[]>([]);
  const addGameHistory = useCallback(
    (g: GameHistory) => setGameHistory((h) => [g, ...h]),
    [],
  );

  const renderScreen = () => {
    switch (screen) {
      case "home":
        return <HomeScreen />;
      case "wallet":
        return <WalletScreen />;
      case "live":
        return <LiveScreen />;
      case "games":
        return <GamesScreen />;
      case "messages":
        return <MessagesScreen />;
      case "profile":
        return <ProfileScreen />;
      default:
        return <HomeScreen />;
    }
  };

  return (
    <AppContext.Provider
      value={{
        user,
        setUser,
        screen,
        setScreen,
        isLoggedIn,
        setIsLoggedIn,
        gameHistory,
        addGameHistory,
        activeLiveStream,
        setActiveLiveStream,
      }}
    >
      <Toaster position="top-center" richColors />
      {/* Mobile frame centering */}
      <div className="min-h-screen bg-gradient-to-br from-slate-800 to-slate-900 flex items-center justify-center p-4">
        <div
          className="relative w-full max-w-[430px] bg-background overflow-hidden shadow-2xl"
          style={{
            height: "100svh",
            maxHeight: 900,
            borderRadius: 40,
            border: "8px solid #1a1a2e",
          }}
        >
          {/* Status bar */}
          <div className="flex items-center justify-between px-6 py-2 bg-background z-50 relative">
            <span className="text-xs font-bold text-foreground">
              {new Date().toLocaleTimeString([], {
                hour: "2-digit",
                minute: "2-digit",
              })}
            </span>
            <div className="flex items-center gap-1">
              <div className="flex gap-0.5">
                {[1, 2, 3, 4].map((i) => (
                  <div
                    key={i}
                    className={"w-0.5 rounded-full flare-gradient"}
                    style={{ height: i * 3 + 2 }}
                  />
                ))}
              </div>
              <span className="text-xs font-bold">⚡</span>
              <span className="text-xs font-bold">98%</span>
            </div>
          </div>

          {/* Screen content */}
          <div className="absolute inset-0 top-10 bottom-0 overflow-hidden">
            <AnimatePresence mode="wait">
              {!isLoggedIn ? (
                <motion.div
                  key="auth"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  exit={{ opacity: 0 }}
                  className="h-full"
                >
                  <AuthScreen />
                </motion.div>
              ) : (
                <motion.div
                  key={screen}
                  initial={{ opacity: 0, x: 20 }}
                  animate={{ opacity: 1, x: 0 }}
                  exit={{ opacity: 0, x: -20 }}
                  transition={{ duration: 0.2 }}
                  className="h-full pb-16"
                >
                  {renderScreen()}
                </motion.div>
              )}
            </AnimatePresence>
          </div>

          {/* Bottom Nav (only when logged in) */}
          {isLoggedIn && <BottomNav />}
        </div>
      </div>
    </AppContext.Provider>
  );
}
