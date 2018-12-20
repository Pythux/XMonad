
import           XMonad
-- import           XMonad.Config.Azerty
import           XMonad.Config.Desktop
import           XMonad.Layout.NoBorders

import qualified Data.Map                as M
import qualified XMonad.StackSet         as W

-- baseConfig = desktopConfig

main :: IO ()
main = xmonad $ defaultConfig {
    layoutHook = noBorders  $  layoutHook defaultConfig,
    keys = myKeys
}


-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

-- it's the FR_AMP, FR_EACU, ... => KC_1, KC_2, ...
-- FR_1 => LSFT(KC_1) => LSFT(FR_AMP)
topRow = [0x26,0xe9,0x22,0x27,0x28,0x2d,0xe8,0x5f,0xe7,0xe0]

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- close focused window
    [ ((modMask .|. shiftMask, xK_c     ), kill)
    ]
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    ++
    [((m .|. modMask .|. shiftMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) topRow,
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
