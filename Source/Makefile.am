bin_PROGRAMS = woof

SOURCE_FILES = \
	am_map.c   am_map.h \
	d_deh.c    d_deh.h \
	d_englsh.h \
	d_event.h \
	d_french.h \
	d_io.h \
	d_items.c  d_items.h \
	d_iwad.c   d_iwad.h \
	d_main.c   d_main.h \
	d_net.c    d_net.h \
	d_player.h \
	d_textur.h \
	d_think.h \
	d_ticcmd.h \
	doomdata.h \
	doomdef.c  doomdef.h \
	doomstat.c doomstat.h \
	doomtype.h \
	dstrings.c dstrings.h \
	f_finale.c f_finale.h \
	f_wipe.c   f_wipe.h \
	g_game.c   g_game.h \
	hu_lib.c   hu_lib.h \
	hu_stuff.c hu_stuff.h \
	i_main.c \
	i_net.c    i_net.h \
	i_savepng.c i_savepng.h \
	i_sound.c  i_sound.h \
	i_system.c i_system.h \
	i_video.c  i_video.h \
	info.c     info.h \
	m_argv.c   m_argv.h \
	m_bbox.c   m_bbox.h \
	m_cheat.c  m_cheat.h \
	m_fixed.h \
	m_menu.c   m_menu.h \
	m_misc.c   m_misc.h \
	m_misc2.c  m_misc2.h \
	m_random.c m_random.h \
	m_swap.h \
	mmus2mid.c mmus2mid.h \
	p_ceilng.c \
	p_doors.c \
	p_enemy.c  p_enemy.h \
	p_floor.c \
	p_genlin.c \
	p_inter.c  p_inter.h \
	p_lights.c \
	p_map.c    p_map.h \
	p_maputl.c p_maputl.h \
	p_mobj.c   p_mobj.h \
	p_plats.c \
	p_pspr.c   p_pspr.h \
	p_saveg.c  p_saveg.h \
	p_setup.c  p_setup.h \
	p_sight.c \
	p_spec.c   p_spec.h \
	p_switch.c \
	p_telept.c \
	p_tick.c   p_tick.h \
	p_user.c   p_user.h \
	r_bsp.c    r_bsp.h \
	r_data.c   r_data.h \
	r_defs.h \
	r_draw.c   r_draw.h \
	r_main.c   r_main.h \
	r_plane.c  r_plane.h \
	r_segs.c   r_segs.h \
	r_sky.c    r_sky.h \
	r_state.h \
	r_things.c r_things.h \
	s_sound.c  s_sound.h \
	sounds.c   sounds.h \
	statdump.c statdump.h \
	st_lib.c   st_lib.h \
	st_stuff.c st_stuff.h \
	tables.c   tables.h \
	v_video.c  v_video.h \
	version.c  version.h \
	w_wad.c    w_wad.h \
	wi_stuff.c wi_stuff.h \
	z_zone.c   z_zone.h

if HAVE_WINDRES
woof_SOURCES = $(SOURCE_FILES) resource.rc
else
woof_SOURCES = $(SOURCE_FILES)
endif

woof_CFLAGS = @SDL_CFLAGS@ @SDL_mixer_CFLAGS@ @SDL_net_CFLAGS@
woof_LDADD = @SDL_LIBS@ @SDL_mixer_LIBS@ @SDL_net_LIBS@

EXTRA_DIST = \
	icon.c \
	manifest.xml \
	resource.rc.in

.rc.o:
	$(WINDRES) $< -o $@
%.o : %.rc
	$(WINDRES) $< -o $@

if HAVE_PYTHON
icon.c : $(top_builddir)/data/woof.png
	$(top_builddir)/data/convert-icon $(top_builddir)/data/woof.png $@
endif
