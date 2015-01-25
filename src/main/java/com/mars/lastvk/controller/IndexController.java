package com.mars.lastvk.controller;

import com.mars.lastvk.entity.Track;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String html() {
        System.out.println("html get:");
        return "/jsp/index.jsp";
    }

    @RequestMapping(value = "/test/{name}", method = RequestMethod.GET)
    public @ResponseBody
    Track get(@PathVariable String name) {
        System.out.println("test get:" + name);
        return Track.random();
    }

    @RequestMapping(value = "/test", method = RequestMethod.POST)
    public ResponseEntity<String> post(@RequestBody Track track) {
        System.out.println("test post:" + track);
        return new ResponseEntity<>(track.toString(), HttpStatus.OK);
    }

    @RequestMapping(value = "/reload/{id}", method = RequestMethod.GET)
    public ModelAndView reload(@PathVariable String id) {
        ModelAndView model = new ModelAndView("/partial.pjsp");
        model.addObject("id", id);
        return model;
    }
}
