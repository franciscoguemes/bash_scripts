#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
# This is a example of how to use the Gtk+ widget gtk.MessageDialog
# in Python.
 
import gtk
 
 
def custom_dialog(dialog_type, title, message):
    '''custom_dialog(dialog_type, title, message)
 
    This is a generic Gtk Message Dialog function.
    dialog_type = this is a Gtk type. The options are:
        gtk.MESSAGE_INFO
        gtk.MESSAGE_WARNING
        gtk.MESSAGE_ERROR
    '''
    dialog = gtk.MessageDialog(None,
                               gtk.DIALOG_MODAL,
                               type=dialog_type,
                               buttons=gtk.BUTTONS_OK)
    dialog.set_markup("<b>%s</b>" % title)
    dialog.format_secondary_markup(message)
    dialog.run()
    dialog.destroy()
 
 
def question_dialog(title, message):
    '''question_dialog(title, message)
 
    This is a generic Gtk Message Dialog function
    for questions.
   '''
    dialog = gtk.MessageDialog(None,
                               gtk.DIALOG_MODAL,
                               type=gtk.MESSAGE_QUESTION,
                               buttons=gtk.BUTTONS_YES_NO)
    dialog.set_markup("<b>%s</b>" % title)
    dialog.format_secondary_markup(message)
    response = dialog.run()
    dialog.destroy()
 
    if response == gtk.RESPONSE_YES:
        custom_dialog(gtk.MESSAGE_INFO,
                      "Your answer has been YES",
                      "Thanks for trying this demo :-)")
    elif response == gtk.RESPONSE_NO:
        custom_dialog(gtk.MESSAGE_INFO,
                      "Your answer has been NO",
                      "Thanks for trying this demo :-)")
    else:
        custom_dialog(gtk.MESSAGE_WARNING,
                      "You din't click any button",
                      "Did you close the window?")
 
 
 
if __name__ == '__main__':
    # Info dialog
    message_type = gtk.MESSAGE_INFO
    info_title = "This is a info title"
    info_description = "This is a info extended message. And \n" + \
                       "this text can have some <b>format</b>." 
    custom_dialog(message_type, info_title, info_description)
 
    # Warning dialog
    message_type = gtk.MESSAGE_WARNING
    warning_title = "This is a warning title"
    warning_description = "This is a warning extended message. And \n" + \
                          "this text can have some <b>format</b>."
    custom_dialog(message_type, warning_title, warning_description)
 
    # error dialog
    message_type = gtk.MESSAGE_ERROR
    error_title = "This is a error title"
    error_description = "This is a error extended message. And \n" + \
                        "this text can have some <b>format</b>."
    custom_dialog(message_type, error_title, error_description)
 
    # question dialog
    question_title = "Do you like this question?"
    question_description = "This is extended question message. And \n" + \
                           "this text can have some <b>format</b>."
    question_dialog(question_title, question_description)
    
