package com.mars.lastvk.controller;

import com.mars.lastvk.lastfmgetrecs.LastFmBean;
import com.mars.lastvk.lastfmgetrecs.entity.JSONTopTrack;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController {

    @Autowired
    LastFmBean lastFm;

    @RequestMapping(value = "/alist", method = RequestMethod.POST)
    public ModelAndView artistList() {
        System.out.println("lastFm");
        ModelAndView view = new ModelAndView("/jsp/subview/artistList.jsp");
        view.addObject("table", new ArrayList());
        return view;
    }

    @RequestMapping(value = "/lastfm", method = RequestMethod.POST)
    public String lastFm() {
        return "/jsp/subview/lastfm.jsp";
    }

    @RequestMapping(value = "/loadArtistList", method = RequestMethod.POST)
    public ModelAndView artistListSubmit(@RequestBody List<String> list) {
        System.out.println("list in:" + list);
        List<JSONTopTrack> ret = lastFm.getTopTracks(list);
        System.out.println("list out:" + ret);
        ModelAndView view = new ModelAndView("/jsp/subview/recs.jsp");
        view.addObject("table", ret);
        return view;
    }

    @RequestMapping(value = "/loadUsername", method = RequestMethod.POST)
    public ModelAndView userNameSubmit(@RequestParam String username) {
        System.out.println("username:" + username);
        List<JSONTopTrack> ret = lastFm.getTopTracks(username);
        System.out.println("list out:" + ret);
        ModelAndView view = new ModelAndView("/jsp/subview/recs.jsp");
        view.addObject("table", ret);
        return view;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String html() {
        System.out.println("html get:");
        return "/jsp/index.jsp";
    }

    @RequestMapping(value = "/reload/{id}", method = RequestMethod.GET)
    public ModelAndView reload(@PathVariable String id) {
        ModelAndView model = new ModelAndView("/partial.pjsp");
        model.addObject("id", id);
        return model;
    }
}
