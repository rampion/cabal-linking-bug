{-# LANGUAGE TemplateHaskell #-}
module Minimal where
$( id [d| unit :: () ; unit = () |] )
