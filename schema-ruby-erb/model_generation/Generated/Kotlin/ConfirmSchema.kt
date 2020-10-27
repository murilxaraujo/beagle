// THIS IS A GENERATED FILE. DO NOT EDIT THIS
/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package br.com.zup.beagle.widget.core

import br.com.zup.beagle.core.BindAttribute
import br.com.zup.beagle.action.ui.ActionSchema

interface ConfirmSchema {
    public val title: BindAttribute<String>?
    public val message: BindAttribute<String>
    public val onPressOk: ActionSchema?
    public val onPressCancel: ActionSchema?
    public val labelOk: String?
    public val labelCancel: String?
}

enum class Mode {
    APPEND,
    PREPEND,
    REPLACE
}