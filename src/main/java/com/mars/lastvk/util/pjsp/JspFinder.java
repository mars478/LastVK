package com.mars.lastvk.util.pjsp;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Collection;
import java.util.Iterator;
import java.util.Scanner;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author mars
 */
public class JspFinder {

    private static Object monitor = new Object();
    private static String DIR_APP = null;
    private static String DIR_JSP = "pages/jsp";
    private static File ROOT_FILE = null;

    public static String getJsp(String id) {
        String jsp = null;
        try {
            File root = getRootFile();
            boolean recursive = true;

            Collection files = FileUtils.listFiles(root, null, recursive);
            for (Iterator iterator = files.iterator(); iterator.hasNext();) {
                File file = (File) iterator.next();
                if (searchId(file, id)) {
                    return file.getCanonicalPath();
                }
            }
        } catch (FileNotFoundException ex) {
            setAppDir(null);
            ex.printStackTrace(System.err);
        } catch (Exception e) {
            e.printStackTrace(System.err);
        }

        return jsp;
    }

    private static boolean searchId(File file, String id) throws FileNotFoundException {
        Scanner txtscan = new Scanner(file);
        while (txtscan.hasNextLine()) {
            String str = txtscan.nextLine().replace("\"", "'");
            if (str.contains("id='" + id + "'")) {
                return true;
            }
        }
        return false;
    }

    private static File getRootFile() {
        synchronized (monitor) {
            return ROOT_FILE = (ROOT_FILE != null) ? ROOT_FILE : new File(DIR_APP + DIR_JSP);
        }
    }

    public static void setJspDir(String dir) {
        if (dir.charAt(0) == '/') {
            dir = dir.substring(1);
        }
        synchronized (monitor) {
            DIR_JSP = dir;
        }
    }

    public static void setAppDir(String dir) {
        synchronized (monitor) {
            DIR_APP = dir;
        }
    }

    public static boolean appDirNeeded() {
        synchronized (monitor) {
            return DIR_APP == null;
        }
    }

    public static String getJspDir() {
        synchronized (monitor) {
            return DIR_JSP;
        }
    }

    private static void initFields() {
        synchronized (monitor) {
            DIR_APP = null;
            ROOT_FILE = null;
        }
    }
}
