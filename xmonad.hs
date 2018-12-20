
import           XMonad
import           XMonad.Config.Desktop
import           XMonad.Layout.NoBorders

-- baseConfig = desktopConfig

main :: IO ()
main = xmonad $ def
    { layoutHook = noBorders  $  layoutHook def }
