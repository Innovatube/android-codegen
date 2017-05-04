package com.innovatube.android;

import com.github.mustachejava.DefaultMustacheFactory;
import com.github.mustachejava.Mustache;
import com.github.mustachejava.MustacheFactory;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Arrays;
import java.util.HashMap;

/**
 * Created by quanlt on 4/23/17.
 */
public class Main {
    public static void main(String[] args) throws IOException {
//        HashMap<String, Object> scopes = new HashMap<>();
//        scopes.put("packageName","com.innovatube.android");
//        scopes.put("imports", Arrays.asList(new Imports("com.android"), new Imports("com.innovatube")));
//        scopes.put("element", Arrays.asList(new Element("text_email","mEmail", "TextView"),new Element("text_age","mAge", "TextView")));
//        Writer writer = new OutputStreamWriter(System.out);
//        MustacheFactory mf = new DefaultMustacheFactory();
//        Mustache mustache = mf.compile("adapter/RecyclerAdapter.mustache");
//        mustache.execute(writer, scopes);
//        writer.flush();
        String layoutName = "item_main.xml";
        String res =  layoutName.substring(0, layoutName.lastIndexOf("."));
        System.out.println(res);
    }

    private static class Imports{
        String className;

        public Imports(String className) {
            this.className = className;
        }
    }

    private static class Element{
        public String id;
        public String variableName;
        public String type;
        public Element(String id, String variableName, String type) {
            this.id = id;
            this.variableName = variableName;
            this.type = type;
        }
    }

}
