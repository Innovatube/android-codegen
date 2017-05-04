package com.innovatube.android.form;

import javax.swing.*;
import java.awt.*;

/**
 * Created by quanlt on 5/3/17.
 */
public class Header extends JPanel {
    private JLabel mEnable;
    private JLabel mType;
    private JLabel mId;
    private JLabel mName;

    public Header() {
        mEnable = new JLabel();
        mEnable.setPreferredSize(new Dimension(100, 26));
        mType = new JLabel("Element");
        mType.setPreferredSize(new Dimension(100, 26));
        mId = new JLabel("Id");
        mId.setPreferredSize(new Dimension(100, 26));
        mName = new JLabel("Name");
        mName.setPreferredSize(new Dimension(100, 26));
        setLayout(new BoxLayout(this, BoxLayout.LINE_AXIS));
        add(Box.createRigidArea(new Dimension(1, 0)));
        add(mEnable);
        add(Box.createRigidArea(new Dimension(11, 0)));
        add(mType);
        add(Box.createRigidArea(new Dimension(11, 0)));
        add(mId);
        add(Box.createRigidArea(new Dimension(12, 0)));
        add(mName);
        add(Box.createHorizontalGlue());
    }
}
