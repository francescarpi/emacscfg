<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- saved from url=(0074)http://www.opensource.apple.com/source/emacs/emacs-51/emacs/lisp/mwheel.el -->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>mwheel.el</title>
<style type="text/css">
.enscript-comment { font-style: italic; color: rgb(178,34,34); }
.enscript-function-name { font-weight: bold; color: rgb(0,0,255); }
.enscript-variable-name { font-weight: bold; color: rgb(184,134,11); }
.enscript-keyword { font-weight: bold; color: rgb(160,32,240); }
.enscript-reference { font-weight: bold; color: rgb(95,158,160); }
.enscript-string { font-weight: bold; color: rgb(188,143,143); }
.enscript-builtin { font-weight: bold; color: rgb(218,112,214); }
.enscript-type { font-weight: bold; color: rgb(34,139,34); }
.enscript-highlight { text-decoration: underline; color: 0; }
</style>
<script type="text/javascript" src="chrome-extension://aadgmnobpdmgmigaicncghmmoeflnamj/ng-inspector.js"></script></head>
<body id="top" data-feedly-mini="yes">
<h1 style="margin:8px;" id="f1">mwheel.el&nbsp;&nbsp;&nbsp;<span style="font-weight: normal; font-size: 0.5em;">[<a href="http://www.opensource.apple.com/source/emacs/emacs-51/emacs/lisp/mwheel.el?txt">plain text</a>]</span></h1>
<hr>
<div></div>
<pre><span class="enscript-comment">;;; mwheel.el --- Mouse support for MS intelli-mouse type mice
</span>
<span class="enscript-comment">;; Copyright (C) 1998, 2000, 2001 Free Software Foundation, Inc.
</span><span class="enscript-comment">;; Maintainer: William M. Perry &lt;<a href="mailto:wmperry@gnu.org">wmperry@gnu.org</a>&gt;
</span><span class="enscript-comment">;; Keywords: mouse
</span>
<span class="enscript-comment">;; This file is part of GNU Emacs.
</span>
<span class="enscript-comment">;; GNU Emacs is free software; you can redistribute it and/or modify
</span><span class="enscript-comment">;; it under the terms of the GNU General Public License as published by
</span><span class="enscript-comment">;; the Free Software Foundation; either version 2, or (at your option)
</span><span class="enscript-comment">;; any later version.
</span>
<span class="enscript-comment">;; GNU Emacs is distributed in the hope that it will be useful,
</span><span class="enscript-comment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of
</span><span class="enscript-comment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
</span><span class="enscript-comment">;; GNU General Public License for more details.
</span>
<span class="enscript-comment">;; You should have received a copy of the GNU General Public License
</span><span class="enscript-comment">;; along with GNU Emacs; see the file COPYING.  If not, write to the
</span><span class="enscript-comment">;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
</span><span class="enscript-comment">;; Boston, MA 02111-1307, USA.
</span>
<span class="enscript-comment">;;; Commentary:
</span>
<span class="enscript-comment">;; This code will enable the use of the infamous 'wheel' on the new
</span><span class="enscript-comment">;; crop of mice.  Under XFree86 and the XSuSE X Servers, the wheel
</span><span class="enscript-comment">;; events are sent as button4/button5 events.
</span>
<span class="enscript-comment">;; I for one would prefer some way of converting the button4/button5
</span><span class="enscript-comment">;; events into different event types, like 'mwheel-up' or
</span><span class="enscript-comment">;; 'mwheel-down', but I cannot find a way to do this very easily (or
</span><span class="enscript-comment">;; portably), so for now I just live with it.
</span>
<span class="enscript-comment">;; To enable this code, simply put this at the top of your .emacs
</span><span class="enscript-comment">;; file:
</span><span class="enscript-comment">;;
</span><span class="enscript-comment">;; (mwheel-install)
</span>
<span class="enscript-comment">;;; Code:
</span>
(require 'custom)

<span class="enscript-comment">;; Setter function for mouse-button user-options.  Switch Mouse Wheel
</span><span class="enscript-comment">;; mode off and on again so that the old button is unbound and
</span><span class="enscript-comment">;; new button is bound to mwheel-scroll.
</span>
(<span class="enscript-keyword">defun</span> <span class="enscript-function-name">mouse-wheel-change-button</span> (var button)
  (set-default var button)
  (<span class="enscript-keyword">when</span> mouse-wheel-mode
    (mouse-wheel-mode 0)
    (mouse-wheel-mode 1)))

(defcustom mouse-wheel-down-button 4
  <span class="enscript-string">"Mouse button number for scrolling down."</span>
  <span class="enscript-reference">:group</span> 'mouse
  <span class="enscript-reference">:type</span> 'integer
  <span class="enscript-reference">:set</span> 'mouse-wheel-change-button)

(defcustom mouse-wheel-up-button 5
  <span class="enscript-string">"Mouse button number for scrolling up."</span>
  <span class="enscript-reference">:group</span> 'mouse
  <span class="enscript-reference">:type</span> 'integer
  <span class="enscript-reference">:set</span> 'mouse-wheel-change-button)

(defcustom mouse-wheel-scroll-amount '(5 . 1)
  <span class="enscript-string">"Amount to scroll windows by when spinning the mouse wheel.
This is actually a cons cell, where the first item is the amount to scroll
on a normal wheel event, and the second is the amount to scroll when the
wheel is moved with the shift key depressed.

Each item should be the number of lines to scroll, or `nil' for near
full screen.
A near full screen is `next-screen-context-lines' less than a full screen."</span>
  <span class="enscript-reference">:group</span> 'mouse
  <span class="enscript-reference">:type</span> '(cons
	  (choice <span class="enscript-reference">:tag</span> <span class="enscript-string">"Normal"</span>
		  (const <span class="enscript-reference">:tag</span> <span class="enscript-string">"Full screen"</span> <span class="enscript-reference">:value</span> nil)
		  (integer <span class="enscript-reference">:tag</span> <span class="enscript-string">"Specific # of lines"</span>))
	  (choice <span class="enscript-reference">:tag</span> <span class="enscript-string">"Shifted"</span>
		  (const <span class="enscript-reference">:tag</span> <span class="enscript-string">"Full screen"</span> <span class="enscript-reference">:value</span> nil)
		  (integer <span class="enscript-reference">:tag</span> <span class="enscript-string">"Specific # of lines"</span>))))

(defcustom mouse-wheel-follow-mouse nil
  <span class="enscript-string">"Whether the mouse wheel should scroll the window that the mouse is over.
This can be slightly disconcerting, but some people may prefer it."</span>
  <span class="enscript-reference">:group</span> 'mouse
  <span class="enscript-reference">:type</span> 'boolean)

(<span class="enscript-keyword">if</span> (not (fboundp 'event-button))
    (<span class="enscript-keyword">defun</span> <span class="enscript-function-name">mwheel-event-button</span> (event)
      (<span class="enscript-keyword">let</span> ((x (symbol-name (event-basic-type event))))
	(<span class="enscript-keyword">if</span> (not (string-match <span class="enscript-string">"^mouse-\\([0-9]+\\)"</span> x))
	    (error <span class="enscript-string">"Not a button event: %S"</span> event))
	(string-to-int (substring x (match-beginning 1) (match-end 1)))))
  (fset 'mwheel-event-button 'event-button))

(<span class="enscript-keyword">if</span> (not (fboundp 'event-window))
    (<span class="enscript-keyword">defun</span> <span class="enscript-function-name">mwheel-event-window</span> (event)
      (posn-window (event-start event)))
  (fset 'mwheel-event-window 'event-window))

(<span class="enscript-keyword">defun</span> <span class="enscript-function-name">mwheel-scroll</span> (event)
  (interactive <span class="enscript-string">"e"</span>)
  (<span class="enscript-keyword">let</span> ((curwin (<span class="enscript-keyword">if</span> mouse-wheel-follow-mouse
		    (<span class="enscript-keyword">prog1</span>
			(selected-window)
		      (select-window (mwheel-event-window event)))))
	(amt (<span class="enscript-keyword">if</span> (memq 'shift (event-modifiers event))
		 (cdr mouse-wheel-scroll-amount)
	       (car mouse-wheel-scroll-amount))))
    (<span class="enscript-keyword">unwind-protect</span>
	(<span class="enscript-keyword">let</span> ((button (mwheel-event-button event)))
	  (<span class="enscript-keyword">cond</span> ((= button mouse-wheel-down-button) (scroll-down amt))
		((= button mouse-wheel-up-button) (scroll-up amt))
		(t (error <span class="enscript-string">"Bad binding in mwheel-scroll"</span>))))
      (<span class="enscript-keyword">if</span> curwin (select-window curwin)))))


<span class="enscript-comment">;;; Note this definition must be at the end of the file, because
</span><span class="enscript-comment">;;; `define-minor-mode' actually calls the mode-function if the
</span><span class="enscript-comment">;;; associated variable is non-nil, which requires that all needed
</span><span class="enscript-comment">;;; functions be already defined.
</span><span class="enscript-comment">;;;###autoload
</span>(define-minor-mode mouse-wheel-mode
  <span class="enscript-string">"Toggle mouse wheel support.
With prefix argument ARG, turn on if positive, otherwise off.
Returns non-nil if the new state is enabled."</span>
  <span class="enscript-reference">:global</span> t
  <span class="enscript-reference">:group</span> 'mouse
  <span class="enscript-comment">;; In the latest versions of XEmacs, we could just use
</span>  <span class="enscript-comment">;; (S-)*mouse-[45], since those are aliases for the button
</span>  <span class="enscript-comment">;; equivalents in XEmacs, but I want this to work in as many
</span>  <span class="enscript-comment">;; versions of XEmacs as it can.
</span>  (<span class="enscript-keyword">let</span> ((keys
	 (<span class="enscript-keyword">if</span> (featurep 'xemacs)
	     (<span class="enscript-keyword">let</span> ((down (intern (format <span class="enscript-string">"button%d"</span> mouse-wheel-down-button)))
		   (up (intern (format <span class="enscript-string">"button%d"</span> mouse-wheel-up-button))))
	       `(,down [(shift ,down)] ,up [(shift ,up)]))
	   (<span class="enscript-keyword">let</span> ((down (intern (format <span class="enscript-string">"mouse-%d"</span> mouse-wheel-down-button)))
		 (s-down (intern (format <span class="enscript-string">"S-mouse-%d"</span> mouse-wheel-down-button)))
		 (up (intern (format <span class="enscript-string">"mouse-%d"</span> mouse-wheel-up-button)))
		 (s-up (intern (format <span class="enscript-string">"S-mouse-%d"</span> mouse-wheel-up-button))))
	     `([,down] [,s-down] [,up] [,s-up])))))
    <span class="enscript-comment">;; This condition-case is here because Emacs 19 will throw an error
</span>    <span class="enscript-comment">;; if you try to define a key that it does not know about.  I for one
</span>    <span class="enscript-comment">;; prefer to just unconditionally do a mwheel-install in my .emacs, so
</span>    <span class="enscript-comment">;; that if the wheeled-mouse is there, it just works, and this way it
</span>    <span class="enscript-comment">;; doesn't yell at me if I'm on my laptop or another machine, etc.
</span>    (<span class="enscript-keyword">condition-case</span> ()
	(dolist (key keys)
	  (<span class="enscript-keyword">cond</span> (mouse-wheel-mode
		 (define-key global-map key 'mwheel-scroll))
		((eq (lookup-key global-map key) 'mwheel-scroll)
		 (define-key global-map key nil))))
      (error nil))))

<span class="enscript-comment">;;; Compatibility entry point
</span><span class="enscript-comment">;;;###autoload
</span>(<span class="enscript-keyword">defun</span> <span class="enscript-function-name">mwheel-install</span> (&amp;optional uninstall)
  <span class="enscript-string">"Enable mouse wheel support."</span>
  (mouse-wheel-mode t))

(provide 'mwheel)

<span class="enscript-comment">;;; mwheel.el ends here
</span></pre>
<hr>
</body></html>