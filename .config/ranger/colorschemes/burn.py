from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class base(ColorScheme):
    progress_bar_color = 8  # grey

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                fg = 0      # black
                bg = 1      # red
            if context.border:
                fg = 240    # dark grey
            if context.image:
                fg = 11     # yellow
            if context.video:
                fg = 173    # orange
            if context.audio:
                fg = 173    # orange
            if context.document:
                fg = 7      # silver
            if context.container:
                attr |= normal
                fg = 1      # red
            if context.directory:
                attr |= normal
                fg = 12     # blue
            elif context.executable and not \
                    any((context.media, context.container,
                       context.fifo, context.socket)):
                attr |= normal
                fg = 2      # green
            if context.socket:
                fg = 3      # olive
                attr |= normal
            if context.fifo or context.device:
                fg = 10     # lime, light green
                if context.device:
                    attr |= normal
            if context.link:
                fg = context.good and 51 or 1 # cyan or red
            if context.bad:
                fg = 1      # red
            if context.tag_marker and not context.selected:
                attr |= normal
                if fg in (7, 8):
                    fg = 1
                else:
                    fg = 1
            if not context.selected and (context.cut or context.copied):
                fg = 15     # white
                bg = 8      # grey
            if context.main_column:
                if context.selected:
                    attr |= normal
                if context.marked:
                    attr |= normal
                    fg = 5  # purple
            if context.badinfo:
                if attr & reverse:
                    bg = 1
                else:
                    fg = 7

        elif context.in_titlebar:
            attr |= normal
            if context.hostname:
                fg = context.bad and 1 or 2 # red or green
            elif context.directory:
                fg = 12     # blue
            elif context.tab:
                if context.good:
                    fg = 0  # black
                    bg = 2  # green
            elif context.link:
                fg = 51     # cyan

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 7  # silver
                elif context.bad:
                    fg = 8  # grey
            if context.marked:
                attr |= normal | reverse
                fg = 2      # yellow
            if context.message:
                if context.bad:
                    attr |= normal
                    fg = 10 # light green
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = 10     # light green
                attr &= ~normal
            if context.vcscommit:
                fg = 5      # purple
                attr &= ~normal


        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = 8

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color


        if context.vcsfile and not context.selected:
            attr &= ~normal
            if context.vcsconflict:
                fg = 11
            elif context.vcschanged:
                fg = 12
            elif context.vcsunknown:
                fg = 210
            elif context.vcsstaged:
                fg = 216
            elif context.vcssync:
                fg = 113
            elif context.vcsignored:
                fg = 141

        elif context.vcsremote and not context.selected:
            attr &= ~normal
            if context.vcssync:
                fg = 12
            elif context.vcsbehind:
                fg = 13
            elif context.vcsahead:
                fg = 9
            elif context.vcsdiverged:
                fg = 10
            elif context.vcsunknown:
                fg = 11

        return fg, bg, attr
