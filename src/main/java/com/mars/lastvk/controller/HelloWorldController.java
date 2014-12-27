package com.mars.lastvk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HelloWorldController {

    public boolean lastfm = true;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView helloWorld() {
        ModelAndView model = new ModelAndView("start");
        model.addObject("msg", "hello world");
        model.addObject("msg2", "test");
        return model;
    }

    @RequestMapping(value = "/reload", method = RequestMethod.POST)
    public ModelAndView reload() {
        ModelAndView mav = new ModelAndView("start");
        System.out.println("reload:"+lastfm);
        mav.addObject("msg2", "233");
        lastfm = !lastfm;
        mav.addObject("lastfm", lastfm);
        return mav;
    }
}
