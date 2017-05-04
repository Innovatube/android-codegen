package com.innovatube.android.form;

import com.innovatube.android.model.Element;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ItemEvent;

/**
 * Created by quanlt on 5/3/17.
 */
public class Entry extends JPanel {
    private Element mElement;
    private EntryList mParent;
    private JCheckBox mEnable;
    private JLabel mType;
    private JLabel mId;
    private JTextField mVariableName;
    private StateChangeListener mStateChangeListener;

    public Entry(Element mElement, EntryList mParent, StateChangeListener mStateChangeListener) {
        this.mElement = mElement;
        this.mParent = mParent;
        mEnable = new JCheckBox();
        mEnable.setPreferredSize(new Dimension(40, 26));
        mEnable.setSelected(true);
        mType = new JLabel(mElement.type);
        mType.setPreferredSize(new Dimension(100, 26));
        mId = new JLabel(mElement.id);
        mId.setPreferredSize(new Dimension(100, 26));
        mVariableName = new JTextField(mElement.variableName);
        mVariableName.setPreferredSize(new Dimension(100, 26));
        setLayout(new BoxLayout(this, BoxLayout.LINE_AXIS));
        add(mEnable);
        add(Box.createRigidArea(new Dimension(10, 0)));
        add(mType);
        add(Box.createRigidArea(new Dimension(10, 0)));
        add(mId);
        add(Box.createRigidArea(new Dimension(10, 0)));
        add(mVariableName);
        add(Box.createHorizontalGlue());
        this.mStateChangeListener = mStateChangeListener;
        mEnable.addItemListener(e -> {
            mType.setEnabled(e.getStateChange() == ItemEvent.SELECTED);
            mId.setEnabled(e.getStateChange() == ItemEvent.SELECTED);
            mVariableName.setEnabled(e.getStateChange() == ItemEvent.SELECTED);
            mStateChangeListener.onStateChange();
        });
        mVariableName.getDocument().addDocumentListener((DocumentChangeListener) () -> {
            mStateChangeListener.onStateChange();
        });
    }

    public Element getElement() {
        return mElement;
    }

    public String getId(){
        return mId.getText();
    }

    public String getType(){
        return mType.getText();
    }
    public boolean isSelected(){
        return mEnable.isSelected();
    }

    public String getVariableName() {
        return mVariableName.getText();
    }
}
