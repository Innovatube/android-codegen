package com.innovatube.android.form;

import com.innovatube.android.utils.Utils;

import javax.swing.*;
import java.awt.*;

/**
 * Created by quanlt on 5/3/17.
 */
public class Location extends JPanel {
    private JTextField mClassName;
    private JTextField mPackage;
    private StateChangeListener mStateChangeListener;

    public Location(String packageName, String fileName, StateChangeListener mStateChangeListener) {
        this.mStateChangeListener = mStateChangeListener;
        JLabel locationLabel = new JLabel("Class ");
        JLabel packageLabel = new JLabel("Package");
        locationLabel.setPreferredSize(new Dimension(120,26));
        packageLabel.setPreferredSize(new Dimension(120,26));
        mPackage = new JTextField(packageName);
        mPackage.setPreferredSize(new Dimension(100,26));
        mClassName = new JTextField(getClassNameFromLayout(fileName));
        mClassName.setPreferredSize(new Dimension(100,26));
        setLayout(new BoxLayout(this, BoxLayout.PAGE_AXIS));

        JPanel classNamePanel = new JPanel();
        classNamePanel.setLayout(new BoxLayout(classNamePanel, BoxLayout.LINE_AXIS));
        classNamePanel.add(locationLabel);
        classNamePanel.add(Box.createRigidArea(new Dimension(10, 0)));
        classNamePanel.add(mClassName);

        add(classNamePanel);
        JPanel packagePanel = new JPanel();
        packagePanel.setLayout(new BoxLayout(packagePanel, BoxLayout.LINE_AXIS));
        packagePanel.add(packageLabel);
        packagePanel.add(Box.createRigidArea(new Dimension(10, 0)));
        packagePanel.add(mPackage);
        add(packagePanel);
        mPackage.getDocument().addDocumentListener((DocumentChangeListener) () -> mStateChangeListener.onStateChange());
        mClassName.getDocument().addDocumentListener((DocumentChangeListener) () -> mStateChangeListener.onStateChange());
    }

    public String getPackageName() {
        return mPackage.getText();
    }

    public String getClassName() {
        return mClassName.getText();
    }

    private String getClassNameFromLayout(String layoutName){
        String fileName = layoutName.substring(0, layoutName.lastIndexOf("."));
        String varName = Utils.snakeCaseToCamelCase(fileName);
        return varName.substring(0,1).toUpperCase()+varName.substring(1);
    }

}
