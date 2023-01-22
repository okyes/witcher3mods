#!/usr/bin/env sh
PREFIX='witcher3mods-'
SUFFIX='.zip'

git ls-remote --heads | xargs -i sh -c "git archive --format=zip \$(echo {} | cut -d' ' -f1) > ${PREFIX}\$(echo {} | cut -d/ -f3)$SUFFIX"

rm -f ${PREFIX}master$SUFFIX \
    ${PREFIX}over-9000-for-friendly-stash$SUFFIX

rm -rf not-recommended/*
mv ${PREFIX}user-settings-*$SUFFIX \
    ${PREFIX}ultimate-roach-improvement-for-friendly-stash$SUFFIX \
    ${PREFIX}free-rune-glyph-removal-and-ultimate-roach-improvement-for-friendly-stash$SUFFIX \
    ${PREFIX}place-of-power-infinite-buff$SUFFIX \
    ${PREFIX}armor-weapon-infinite-buff$SUFFIX \
    ${PREFIX}correct-sorting-for-more-quick-slots$SUFFIX not-recommended

rm -rf questionable/*
mv ${PREFIX}fast-stash-for-friendly-hud$SUFFIX \
    ${PREFIX}free-craft$SUFFIX \
    ${PREFIX}input-xml-for-appearances-menu-mod$SUFFIX questionable

rm -rf w3mm/*
mv ${PREFIX}input-xml-*$SUFFIX \
    ${PREFIX}input-settings-*$SUFFIX w3mm
