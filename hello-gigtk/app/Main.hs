  
{-# LANGUAGE OverloadedStrings, OverloadedLabels #-}

{-# OPTIONS_GHC -fno-warn-unused-do-bind #-}

{- Hello World example of GTK+ documentation. For information please refer to README -}

module Main where

import qualified Data.Text as T
import Data.Text (Text)

import qualified GI.Gio as Gio
import qualified GI.Gtk as Gtk
import GI.Gtk.Objects.TextBuffer ( TextBuffer )

import Data.GI.Base


printHello :: Gtk.TextView -> Gtk.Label -> IO ()
printHello textView label = 
    do
        buffer <- get textView #buffer
        text <- get buffer #text

        case text of
            Just a ->
                do 
                    Gtk.labelSetText label a 
            Nothing -> putStrLn "ss"

activateApp :: Gtk.Application -> IO ()
activateApp app = do
  w <- new Gtk.ApplicationWindow [ #application := app
                                 , #title := "Haskell Gi - Examples - Hello World"
                                 , #defaultHeight := 200
                                 , #defaultWidth := 200
                                 ]

  bbox <- new Gtk.ButtonBox [ #orientation := Gtk.OrientationHorizontal ]
  #add w bbox

  textView <- new Gtk.TextView []
  #add bbox textView

  label <- new Gtk.Label []
  #add bbox label 

  btn <- new Gtk.Button [ #label := "Click"]
  on btn #clicked $ printHello textView label
  #add bbox btn
  
  #showAll w
  return ()

main :: IO ()
main = do
  app <- new Gtk.Application [ #applicationId := "haskell-gi.examples.hello-world"
                             , #flags := [ Gio.ApplicationFlagsFlagsNone ]
                             ]
  on app #activate $ activateApp app
  Gio.applicationRun app Nothing
  return ()