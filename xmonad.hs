
import           XMonad
-- import           XMonad.Config.Azerty
import           XMonad.Config.Desktop
import           XMonad.Hooks.ManageHelpers
-- import           XMonad.Layout.Fullscreen
-- import           XMonad.Hooks.EwmhDesktops -- another way to fullscreen
import           XMonad.Layout.NoBorders
import           XMonad.Layout.ResizableTile

import XMonad.Hooks.ManageDocks(manageDocks,avoidStruts)
import XMonad.Hooks.EwmhDesktops(fullscreenEventHook,ewmh)
import XMonad.Hooks.ManageHelpers(doFullFloat,isFullscreen)


import qualified Data.Map                    as M
import qualified XMonad.StackSet             as W

main :: IO ()
main = xmonad $ ewmh $ def {
    handleEventHook = myHandleEventHook,
    manageHook = myManageHook,
    layoutHook = noBorders . smartBorders $ myLayoutHook,
    focusedBorderColor = "#0ca2ff",
    keys = myKeys <+> keys def
}
tall = ResizableTall 1 (1/10) (1/2) []
myLayoutHook = tall

myManageHook = manageDocks <+> manageHook desktopConfig <+> (isFullscreen --> doFullFloat)
myHandleEventHook = handleEventHook desktopConfig <+> fullscreenEventHook

-- it's the FR_AMP, FR_EACU, ... => KC_1, KC_2, ...
-- FR_1 => LSFT(KC_1) => LSFT(FR_AMP)
topRow = [0x26,0xe9,0x22,0x27,0x28,0x2d,0xe8,0x5f,0xe7,0xe0]

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- close focused window
    [ ((modMask .|. shiftMask, xK_c     ), kill)
    , ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((modMask, xK_Left),  sendMessage MirrorExpand)
    , ((modMask, xK_Right), sendMessage MirrorShrink)
    ]
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    ++
    [((m .|. modMask .|. shiftMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) topRow,
          (f, m) <- [(W.greedyView, 0), (W.shift, controlMask)]]
