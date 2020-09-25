-module(pass_no_nested_try_catch_elvis_attr).

-dialyzer({nowarn_function, bad2/0}).

-ignore_xref([{maybe, throw, 1}]).
-ignore_xref([{a_function, that_deals, 2}]).

-export([
         bad1/0,
         bad2/0,
         good1/0,
         good2/0
        ]).

-elvis([{elvis_style, no_nested_try_catch, disable}]).
bad1() ->
  try
    maybe:throw(exception1),
    try
      maybe:throw(exception2),
      "We are safe!"
    catch
      _:exception2 ->
        "Oh, no! Exception #2"
    end
  catch
    _:exception1 ->
      "Bummer! Exception #1"
  end.

bad2() ->
  try
    maybe:throw(exception1),
    try
      maybe:throw(exception2),
      "We are safe!"
    catch
      _:exception2 ->
        "Oh, no! Exception #2"
    end,
    try
      maybe:throw(exception3),
      "We are safe!"
    catch
      _:exception3 ->
        "Oh, no! Exception #3"
    end
  catch
    _:exception1 ->
      "Bummer! Exception #1"
  end.

good1() ->
  try
    maybe:throw(exception1),
    maybe:throw(exception2),
    "We are safe!"
  catch
    _:exception1 ->
      "Bummer! Exception #1";
    _:exception2 ->
      "Oh, no! Exception #2"
  end.

good2() ->
  try
    maybe:throw(exception1),
    a_function:that_deals(with, exception2),
    "We are safe!"
  catch
    _:exception1 ->
      "Bummer! Exception #1"
  end.
