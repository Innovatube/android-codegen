package com.innovatube.android;

import com.android.tools.idea.npw.project.AndroidProjectPaths;
import com.android.tools.idea.npw.project.AndroidSourceSet;
import com.android.tools.idea.npw.template.ConfigureTemplateParametersStep;
import com.android.tools.idea.npw.template.RenderTemplateModel;
import com.android.tools.idea.npw.template.TemplateHandle;
import com.android.tools.idea.ui.wizard.StudioWizardDialogBuilder;
import com.android.tools.idea.wizard.model.ModelWizard;
import com.innovatube.android.utils.Utils;
import com.intellij.ide.IdeView;
import com.intellij.openapi.actionSystem.*;
import com.intellij.openapi.module.Module;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.ui.Messages;
import com.intellij.openapi.vfs.VirtualFile;
import com.intellij.psi.JavaDirectoryService;
import com.intellij.psi.PsiDirectory;
import com.intellij.psi.PsiManager;
import com.intellij.psi.PsiPackage;
import org.jetbrains.android.facet.AndroidFacet;

import java.io.File;
import java.util.List;

/**
 * Created by quanlt on 4/23/17.
 */
public class TemplateWizardAction extends AnAction {
    private Project mCurrentProject;
    private DataContext mDataContext;
    private RenderTemplateModel myTemplateModel;
    private AndroidFacet mAndroidFacet;
    private String templateName;

    public TemplateWizardAction(String templateName) {
        super("Generate " + templateName);
        this.templateName = templateName;
    }

    @Override
    public void actionPerformed(AnActionEvent event) {
        mCurrentProject = event.getData(DataKeys.PROJECT);
        mDataContext = event.getDataContext();
        File templateDirectory = Utils.getTemplateDirectory();
        if (templateDirectory == null) {
            Messages.showMessageDialog(mCurrentProject, "Directory not found!", "Generate Template", Messages.getInformationIcon());
        }
        templateDirectory = new File(templateDirectory, templateName);
        if (!templateDirectory.exists()) {
            Messages.showMessageDialog(mCurrentProject, templateName + " doesn't exist!", "Generate Template", Messages.getErrorIcon());
        }
        VirtualFile targetFile = CommonDataKeys.VIRTUAL_FILE.getData(mDataContext);
        assert targetFile != null;
        VirtualFile targetDirectory = targetFile;
        if (!targetDirectory.isDirectory()) {
            targetDirectory = targetFile.getParent();
            assert targetDirectory != null;
        }

        Module module = LangDataKeys.MODULE.getData(mDataContext);
        assert module != null;
        mAndroidFacet = AndroidFacet.getInstance(module);
        assert mAndroidFacet != null;

        AndroidProjectPaths app = new AndroidProjectPaths(mAndroidFacet);
        AndroidSourceSet sourceSet = new AndroidSourceSet("", app);
        List<AndroidSourceSet> androidSourceSets = AndroidSourceSet.getSourceSets(mAndroidFacet, targetDirectory);


        IdeView view = LangDataKeys.IDE_VIEW.getData(event.getDataContext());
        VirtualFile imHere = view.getDirectories()[0].getVirtualFile();
        PsiDirectory psiDirectory = PsiManager.getInstance(mCurrentProject).findDirectory(imHere);
        PsiPackage psiPackage = JavaDirectoryService.getInstance().getPackage(psiDirectory);
        String packageName = psiPackage.getQualifiedName();
        myTemplateModel = new RenderTemplateModel(mCurrentProject, new TemplateHandle(templateDirectory), packageName, sourceSet, "");


        ModelWizard.Builder wizardBuilder = new ModelWizard.Builder();
        ConfigureTemplateParametersStep step = new ConfigureTemplateParametersStep(
                myTemplateModel,
                "Configure Template",
                androidSourceSets,
                mAndroidFacet
        );
        wizardBuilder.addStep(step);
        ModelWizard modelWizard = wizardBuilder.build();

        // create and show the dialog
        new StudioWizardDialogBuilder(modelWizard, "New Android Activity")
                .setProject(module.getProject())
                .build()
                .show();
    }

    private boolean isAvailable(DataContext dataContext) {
        final Module module = LangDataKeys.MODULE.getData(dataContext);
        final IdeView view = LangDataKeys.IDE_VIEW.getData(dataContext);

        if (module == null ||
                view == null ||
                view.getDirectories().length == 0 ||
                AndroidFacet.getInstance(module) == null) {
            return false;
        }
        return true;
    }

    @Override
    public void update(AnActionEvent e) {
        DataContext dataContext = e.getDataContext();
        super.update(e);
        e.getPresentation().setVisible(isAvailable(dataContext));
    }
}
