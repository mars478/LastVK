package com.mars.lastvk.util.pjsp;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

/**
 *
 * @author mars
 */
@WebServlet(urlPatterns = "*.pjsp")
public class PartialJspRenderer extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (JspFinder.appDirNeeded()) {
            JspFinder.setAppDir(getServletContext().getRealPath("/").replace('\\', '/') + "/");
        }

        String response = "";
        String id = (String) req.getAttribute("id");
        if (id != null && !id.isEmpty()) {
            String jsp = JspFinder.getJsp(id);
            if (jsp != null && !(jsp = jsp.replaceAll("/", "\\\\").replaceAll("\\\\", "/")).isEmpty()) {
                String rootDir = JspFinder.getJspDir().replaceAll("/", "\\\\").replaceAll("\\\\", "/");
                String template = jsp.substring(jsp.lastIndexOf(rootDir) - 1);
                System.out.println("reload:" + id + " from " + template);

                CharArrayWriterResponse customResponse = new CharArrayWriterResponse(resp);
                req.getRequestDispatcher(template).forward(req, customResponse);
                Document doc = Jsoup.parse(customResponse.getOutput());
                response = doc.getElementById(id).outerHtml();
            }
        }
        resp.getWriter().write(response);
    }
}

class CharArrayWriterResponse extends HttpServletResponseWrapper {

    private final CharArrayWriter charArray = new CharArrayWriter();

    public CharArrayWriterResponse(HttpServletResponse response) {
        super(response);
    }

    @Override
    public PrintWriter getWriter() throws IOException {
        return new PrintWriter(charArray);
    }

    public String getOutput() {
        return charArray.toString();
    }
}
