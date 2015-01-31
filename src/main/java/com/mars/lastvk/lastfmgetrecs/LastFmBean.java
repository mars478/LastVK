package com.mars.lastvk.lastfmgetrecs;

import com.mars.lastvk.lastfmgetrecs.engine.LastFMRec;
import java.util.Iterator;
import java.util.List;
import net.dontdrinkandroot.lastfm.api.model.Period;
import org.springframework.stereotype.Component;

/**
 *
 * @author mars
 */

@Component(value = "lastFm")
public class LastFmBean {

    public List getTopTracks(String username) {
        try {
            return (username == null || "".equals(username.trim()))
                    ? null
                    : new LastFMRec().process(username);
        } catch (Exception ex) {
            return null;
        }
    }

    public List getTopTracks(List<String> artists) {
        if (artists != null) {
            for (Iterator<String> iterator = artists.iterator(); iterator.hasNext();) {
                String val = iterator.next();
                if (val == null || "".equals(val.trim())) {
                    iterator.remove();
                }
            }
            String[] args = artists.toArray(new String[artists.size()]);
            return getTopTracks(args);
        }
        return null;
    }

    private List getTopTracks(String... args) {
        try {
            return new LastFMRec().process(Period.OVERALL, args);
        } catch (Exception ex) {
            return null;
        }
    }

}
