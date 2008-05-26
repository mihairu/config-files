#!/usr/bin/perl

sub build_channels
{
    $str = "";
    $infolist = weechat::infolist_get("buffer", "");
    while (weechat::infolist_next($infolist))
    {
        $str = $str.weechat::color("color_chat_buffer").weechat::infolist_integer($infolist, "number").weechat::color("color_chat").".".weechat::infolist_string($infolist, "category").weechat::color("color_chat_delimiters")."/".weechat::color("color_chat").weechat::infolist_string($infolist, "name")."\n";
    }
    weechat::infolist_free($infolist);
    return $str;
}

weechat::register("channels", "FlashCode <flashcode\@flashtux.org>", "0.1", "GPL", "Channels demo bar for WeeChat 0.2.7, enjoy!", "", "");
weechat::bar_item_new("channels", "build_channels");
weechat::bar_new("bar_channels", "root", "left", "20", "1", "channels");
