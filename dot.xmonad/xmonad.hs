{- xmonad.hs
 -}

-------------------------------------------------------------------------------
-- Imports --
-- stuff
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import System.IO (Handle, hPutStrLn)

import XMonad.Actions.UpdatePointer

-- utils
import XMonad.Util.Run (spawnPipe)

-- hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile

import XMonad.Actions.CycleWS

-------------------------------------------------------------------------------
-- Main --
main = do
       h <- spawnPipe "xmobar"
       xmonad $ defaultConfig 
              { workspaces = workspaces'
              , modMask = modMask'
              , borderWidth = borderWidth'
              , normalBorderColor = normalBorderColor'
              , focusedBorderColor = focusedBorderColor'
              , terminal = terminal'
              , keys = keys'
              , logHook = logHook' h 
              , layoutHook = layoutHook'
              , manageHook = manageHook'
              , focusFollowsMouse = True
              , startupHook = setWMName "LG3D"
              }

-------------------------------------------------------------------------------
-- Hooks --
manageHook' :: ManageHook
manageHook' = (doF W.swapDown) <+> manageHook defaultConfig <+> manageDocks <+> (isFullscreen --> doFullFloat)

logHook' :: Handle ->  X ()
logHook' h = (dynamicLogWithPP $ xmobarPP { ppSep = " | ", ppTitle = id, ppCurrent = wrap "[" "]", ppOutput = hPutStrLn h }) >> updatePointer (Relative 0.5 0.5)

layoutHook' = customLayout

-------------------------------------------------------------------------------
-- Looks --
-- borders
borderWidth' :: Dimension
borderWidth' = 0

normalBorderColor', focusedBorderColor' :: String
normalBorderColor'  = "#3299CC"
focusedBorderColor' = "#3299CC"

-- workspaces
workspaces' :: [WorkspaceId]
workspaces' = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "A", "S", "D", "F"]

-- layouts
customLayout = avoidStruts $ smartBorders tiled ||| smartBorders (Mirror tiled)  ||| noBorders Full
  where
    tiled = ResizableTall 1 (2/100) (1/2) []

-------------------------------------------------------------------------------
-- Terminal --
terminal' :: String
--terminal' = "xterm -bg black -fg white -fa Monospace -fs 10 +u8"
terminal' = "gnome-terminal"

-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' :: KeyMask
modMask' = mod4Mask

-- keys
keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask,               xK_Return   ), spawn $ XMonad.terminal conf)
    , ((modMask,               xK_p        ), spawn "$(yeganesh -x)")
    , ((modMask,               xK_o        ), spawn "opera -newwindow")
    , ((modMask .|. shiftMask, xK_c        ), kill)
    , ((0                    , xK_F12      ), spawn "gnome-screensaver-command -l")
    , ((modMask,               xK_Page_Up  ), spawn "amixer -q set Master 2%+")
    , ((modMask,               xK_Page_Down), spawn "amixer -q set Master 2%-")

    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask,               xK_b     ), sendMessage ToggleStruts)

    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- focus and swapping
    , ((modMask,               xK_Up    ), windows W.focusUp)
    , ((modMask,               xK_Down  ), windows W.focusDown)
    , ((modMask .|. shiftMask, xK_Up    ), windows W.swapUp)
    , ((modMask .|. shiftMask, xK_Down  ), windows W.swapDown)
    , ((modMask,               xK_Home  ), windows W.focusMaster)
    , ((modMask .|. shiftMask, xK_Home  ), windows W.shiftMaster)

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), restart "xmonad" True)

    -- Moving between workspaces
    , ((modMask              , xK_Left  ), prevWS)
    , ((modMask .|. shiftMask, xK_Left  ), shiftToPrev)
    , ((modMask              , xK_Right ), nextWS)
    , ((modMask .|. shiftMask, xK_Right ), shiftToNext)
    , ((modMask .|. shiftMask, xK_Tab   ), toggleWS)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0, xK_a, xK_s, xK_d, xK_f])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-------------------------------------------------------------------------------
