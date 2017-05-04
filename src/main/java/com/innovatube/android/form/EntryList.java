package com.innovatube.android.form;

import com.github.mustachejava.DefaultMustacheFactory;
import com.github.mustachejava.Mustache;
import com.github.mustachejava.MustacheFactory;
import com.innovatube.android.model.Element;
import com.innovatube.android.utils.Utils;
import com.intellij.openapi.ide.CopyPasteManager;
import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiFile;
import com.intellij.ui.JBColor;
import com.intellij.ui.components.JBScrollPane;

import javax.swing.*;
import javax.swing.border.LineBorder;
import java.awt.*;
import java.awt.datatransfer.StringSelection;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * Created by quanlt on 5/3/17.
 */
public class EntryList extends JPanel implements StateChangeListener {
    private ArrayList<Element> mElements;
    private ArrayList<Entry> mEntries;
    private String mPackageName;
    private Project mProject;
    private PsiFile mPsiFile;
    private JTextArea mCode;
    private JButton mCancelButton;
    private JButton mCopyButton;
    private Location mLocation;


    public EntryList(Project project, PsiFile psiFile, ArrayList<Element> mElements) {
        this.mProject = project;
        this.mElements = mElements;
        this.mPsiFile = psiFile;
        mEntries = new ArrayList<>();
        setPreferredSize(new Dimension(640, 360));
        setLayout(new BoxLayout(this, BoxLayout.PAGE_AXIS));
        addLocations();
        addHeader();
        addFields();
        addResultPanel();
        addButtons();
        generateCode();
    }

    private void addLocations() {
        mLocation = new Location("com.innovatube", mPsiFile.getName(), this);
        add(mLocation);
        revalidate();
    }

    private void addHeader() {
        add(new Header());
        revalidate();
    }

    private void addFields() {
        JPanel container = new JPanel();
        container.setLayout(new BoxLayout(container, BoxLayout.PAGE_AXIS));
        container.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        JPanel fieldsPanel = new JPanel();
        fieldsPanel.setLayout(new BoxLayout(fieldsPanel, BoxLayout.PAGE_AXIS));
        fieldsPanel.add(Box.createRigidArea(new Dimension(0, 5)));
        for (Element element : mElements) {
            Entry entry = new Entry(element, this, this);
            fieldsPanel.add(entry);
            mEntries.add(entry);
        }
        fieldsPanel.add(Box.createVerticalGlue());
        fieldsPanel.add(Box.createRigidArea(new Dimension(0, 5)));
        container.add(fieldsPanel);
        add(container, BorderLayout.CENTER);
        revalidate();
    }


    private void addResultPanel() {
        JPanel container = new JPanel();
        container.setLayout(new BoxLayout(container, BoxLayout.PAGE_AXIS));
        container.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        JPanel centerPanel = new JPanel(new BorderLayout());
        mCode = new JTextArea("blah blah");
        mCode.setBorder(new LineBorder(JBColor.gray));
        centerPanel.add(new JBScrollPane(mCode), BorderLayout.CENTER);
        container.add(centerPanel);
        add(new JLabel("Result: "));
        add(container);
        revalidate();
    }

    private void addButtons() {
        mCancelButton = new JButton();
        mCancelButton.setPreferredSize(new Dimension(120, 26));
        mCancelButton.setText("Cancel");
        mCancelButton.setVisible(true);
        mCopyButton = new JButton();
        mCopyButton.setText("Copy to clipboard");
        mCopyButton.setVisible(true);
        mCopyButton.addActionListener(e -> {
            CopyPasteManager.getInstance().setContents(new StringSelection(mCode.getText()));
            Utils.showInfoNotification(mProject, "Source code was copied to clipboard");
        });
        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new BoxLayout(buttonPanel, BoxLayout.LINE_AXIS));
        buttonPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        buttonPanel.add(Box.createHorizontalGlue());
        buttonPanel.add(mCancelButton);
        buttonPanel.add(Box.createRigidArea(new Dimension(10, 0)));
        buttonPanel.add(mCopyButton);
        add(buttonPanel, BorderLayout.PAGE_END);
        revalidate();
    }

    public JButton getCancelButton() {
        return mCancelButton;
    }

    public JButton getCopyButton() {
        return mCopyButton;
    }

    @Override
    public void onStateChange() {
        generateCode();
    }

    private void generateCode() {
        Writer writer = new StringWriter();
        MustacheFactory factory = new DefaultMustacheFactory();
        try {
            Mustache mustache = factory.compile("adapter/RecyclerAdapter.mustache");
            HashMap<String, Object> scopes = new HashMap<>();
            scopes.put("element", mEntries.stream()
                    .filter(entry -> entry.isSelected())
                    .map(entry -> new Element(entry.getId(), entry.getType(), entry.getVariableName()))
                    .collect(Collectors.toList()));
            scopes.put("packageName", mLocation.getPackageName());
            scopes.put("className", mLocation.getClassName());
            mustache.execute(writer, scopes);
            writer.flush();
            mCode.setText(writer.toString());
        } catch (IOException e) {
            mCode.setText(e.getMessage());
            e.printStackTrace();
        }

    }

}
