package com.innovatube.android;

import com.innovatube.android.form.EntryList;
import com.innovatube.android.model.Element;
import com.innovatube.android.utils.Utils;
import com.intellij.codeInsight.CodeInsightActionHandler;
import com.intellij.codeInsight.generation.actions.BaseGenerateAction;
import com.intellij.openapi.actionSystem.AnAction;
import com.intellij.openapi.actionSystem.AnActionEvent;
import com.intellij.openapi.actionSystem.PlatformDataKeys;
import com.intellij.openapi.editor.Editor;
import com.intellij.openapi.fileTypes.FileType;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.PsiFile;
import org.jetbrains.annotations.NotNull;

import javax.swing.*;
import java.util.ArrayList;

/**
 * Created by quanlt on 5/3/17.
 */
public class AdapterAction extends AnAction {
    private JFrame mDialog;

    @Override
    public void actionPerformed(AnActionEvent event) {
        Project project = getEventProject(event);
        PsiFile psiFile = event.getData(PlatformDataKeys.PSI_FILE);
        if (psiFile.getParent().getName().contains("layout")) {
            showCodeDialog(project, psiFile);
        }else {
            Utils.showInfoNotification(project, "Generate Adapter is only available for layout");
        }
    }

    private void showCodeDialog(Project project, PsiFile psiFile) {
        ArrayList<Element> elements = Utils.getIDsFromLayout(psiFile);
        EntryList panel = new EntryList(project,psiFile,  elements);
        mDialog = new JFrame();
        mDialog.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        mDialog.getRootPane().setDefaultButton(panel.getCopyButton());
        panel.getCancelButton().addActionListener(e->mDialog.dispose());
        mDialog.getContentPane().add(panel);
        mDialog.pack();
        mDialog.setLocationRelativeTo(null);
        mDialog.setVisible(true);
    }
}