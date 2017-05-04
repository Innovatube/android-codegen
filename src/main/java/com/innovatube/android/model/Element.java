package com.innovatube.android.model;

/**
 * Created by quanlt on 5/3/17.
 */

import com.innovatube.android.utils.Utils;

import javax.rmi.CORBA.Util;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Element {

    private static final Pattern sIdPattern = Pattern.compile("@\\+?(android:)?id/([^$]+)$", Pattern.CASE_INSENSITIVE);
    public String id;
    public boolean isAndroidNS = false;
    public String nameFull;
    public String type;
    public String variableName;

    public Element(String name, String id) {
        final Matcher matcher = sIdPattern.matcher(id);
        if (matcher.find() && matcher.groupCount() > 0) {
            this.id = matcher.group(2);

            String androidNS = matcher.group(1);
            this.isAndroidNS = !(androidNS == null || androidNS.length() == 0);
        }

        String[] packages = name.split("\\.");
        if (packages.length > 1) {
            this.nameFull = name;
            this.type = packages[packages.length - 1];
        } else {
            this.nameFull = null;
            this.type = name;
        }

        this.variableName = getVariableName();
    }

    public Element(String id, String type, String variableName) {
        this.id = id;
        this.type = type;
        this.variableName = variableName;
    }

    private String getVariableName() {
        return Utils.snakeCaseToCamelCase(this.id);
    }


}

