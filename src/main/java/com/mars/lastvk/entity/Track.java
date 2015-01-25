package com.mars.lastvk.entity;

import org.apache.commons.lang3.RandomStringUtils;

public class Track {

    String artist;
    String title;

    public static Track random() {
        String artist = RandomStringUtils.random(12);
        String title = RandomStringUtils.random(20);
        return new Track(artist, title);
    }

    public Track(String artist, String title) {
        this.artist = artist;
        this.title = title;
    }

    private Track() {
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Override
    public String toString() {
        return artist + "-" + title;
    }
}
