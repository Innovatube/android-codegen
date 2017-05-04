package com.innovatube.android.form;

import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

/**
 * Created by quanlt on 5/3/17.
 */
public interface DocumentChangeListener extends DocumentListener{
    @Override
    default void insertUpdate(DocumentEvent e) {
        onDocumentChange();
    }

    @Override
    default void removeUpdate(DocumentEvent e) {
        onDocumentChange();
    }

    @Override
    default void changedUpdate(DocumentEvent e) {
        onDocumentChange();
    }

    void onDocumentChange();
}
