package com.innovatube.android;

import com.innovatube.android.utils.Utils;
import com.intellij.openapi.actionSystem.ActionManager;
import com.intellij.openapi.actionSystem.DefaultActionGroup;
import com.intellij.openapi.components.ApplicationComponent;
import org.jetbrains.annotations.NotNull;

import java.io.File;

/**
 * Created by quanlt on 4/25/17.
 */
public class InnovatubePluginRegistration implements ApplicationComponent {
    @Override
    public void initComponent() {
        File templateDirectory = Utils.getTemplateDirectory();
        String[] directories = templateDirectory.list((current, name) -> new File(current, name).isDirectory() && !name.contains("common"));

        ActionManager am = ActionManager.getInstance();
        DefaultActionGroup windowM = (DefaultActionGroup) am.getAction("AndroidCodeGen.NewMenu.Innovatube");
        TemplateWizardAction action;

        for (String template : directories) {
            action = new TemplateWizardAction(template);
            am.registerAction(template, action);
            windowM.addAction(action);
        }

    }

    @Override
    public void disposeComponent() {

    }

    @NotNull
    @Override
    public String getComponentName() {
        return "MVP Template";
    }
}
